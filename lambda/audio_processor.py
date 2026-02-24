import json
import boto3
import os
import subprocess
import librosa
import soundfile as sf

s3 = boto3.client('s3')

TMP_DIR = "/tmp"

# Plugin Modules (DAW-style effects) 

def normalize_audio(input_path, output_path):
    subprocess.run([
        'ffmpeg', '-i', input_path,
        '-af', 'loudnorm',
        output_path, '-y'
    ], check=True)


def apply_eq(input_path, output_path):
    # Simple EQ: reduce lows and boost highs
    subprocess.run([
        'ffmpeg', '-i', input_path,
        '-af', 'equalizer=f=100:t=h:width=200:g=-5, equalizer=f=5000:t=h:width=2000:g=3',
        output_path, '-y'
    ], check=True)


def apply_reverb(input_path, output_path):
    subprocess.run([
        'ffmpeg', '-i', input_path,
        '-af', 'aecho=0.8:0.9:1000:0.3',
        output_path, '-y'
    ], check=True)


# Analysis (Tempo, Beat Grid) 

def analyze_audio(path):
    y, sr = librosa.load(path)
    tempo, beats = librosa.beat.beat_track(y=y, sr=sr)
    duration = librosa.get_duration(y=y, sr=sr)

    return {
        "tempo": float(tempo),
        "duration": float(duration),
        "beats": len(beats)
    }


# Plugin Chain (like Logic Pro channel strip) 

def process_chain(input_path, output_path):
    step1 = os.path.join(TMP_DIR, "step1.wav")
    step2 = os.path.join(TMP_DIR, "step2.wav")

    normalize_audio(input_path, step1)
    apply_eq(step1, step2)
    apply_reverb(step2, output_path)


#Lambda Handler 

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    project_id = os.path.dirname(key)
    filename = os.path.basename(key)

    input_path = os.path.join(TMP_DIR, filename)
    output_filename = f"mix_{filename}"
    output_path = os.path.join(TMP_DIR, output_filename)

    # 1. Download track
    s3.download_file(bucket, key, input_path)

    # 2. Analyze (tempo detection like DAW project setup)
    analysis = analyze_audio(input_path)

    # 3. Process through plugin chain (Channel Strip)
    process_chain(input_path, output_path)

    # 4. Upload bounced track
    processed_key = f"{project_id}/mix/{output_filename}"
    s3.upload_file(output_path, bucket, processed_key)

    # 5. Save project metadata
    metadata_key = f"{project_id}/metadata/{filename}.json"
    s3.put_object(
        Bucket=bucket,
        Key=metadata_key,
        Body=json.dumps(analysis),
        ContentType="application/json"
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "project": project_id,
            "processed_file": processed_key,
            "analysis": analysis
        })
    }
