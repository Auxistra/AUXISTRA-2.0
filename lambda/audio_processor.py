import json
import boto3
import os
import subprocess
import librosa
import soundfile as sf

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # This function processes uploaded audio for stem analysis or normalization
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    download_path = f'/tmp/{os.path.basename(key)}'
    output_path = f'/tmp/processed_{os.path.basename(key)}'

    # 1. Download from S3
    s3.download_file(bucket, key, download_path)

    # 2. Process with Librosa (e.g., detect tempo/beats or normalize)
    y, sr = librosa.load(download_path)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)

    # Example: Simple normalization using FFmpeg via subprocess
    # In a real scenario, you'd use Spleeter or similar for stem separation
    subprocess.run(['ffmpeg', '-i', download_path, '-af', 'loudnorm', output_path, '-y'])

    # 3. Upload back to S3
    processed_key = f'processed/{os.path.basename(output_path)}'
    s3.upload_file(output_path, bucket, processed_key)

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Audio processed successfully',
            'tempo': float(tempo),
            'processed_key': processed_key
        })
    }
