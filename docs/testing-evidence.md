# AUXISTRA 2.0 Testing Evidence

## 1. Purpose of this document

This document records the testing strategy and evidence for Auxistra 2.0 in a format suitable for coursework discussion. It explains:
- what types of testing are used
- why those tests were selected
- how the tests support confidence in the implementation
- what remains out of scope

The emphasis is on truthful evidence rather than inflated coverage claims.

## 2. Testing objectives

The project testing approach aims to verify that:

1. the Flutter application can bootstrap reliably
2. login-state-dependent navigation behaves correctly
3. provider logic remains stable for core coursework scenarios
4. backend code is syntactically valid
5. common regressions are caught automatically in CI

Because the repository is designed to run in assessor/student environments without extra packages, the strategy intentionally favors:
- deterministic tests
- low setup overhead
- no external cloud dependency
- no database dependency
- no network dependency for core test evidence

## 3. Test strategy overview

The testing approach is layered but lightweight.

| Test level | Purpose | Tooling |
|---|---|---|
| Static analysis | Catch code smells and compile-time issues | `flutter analyze` |
| Widget tests | Validate UI boot and navigation behavior | `flutter_test` |
| Provider/unit-style tests | Validate state logic without live services | `flutter_test` |
| Backend syntax check | Catch immediate server-side syntax issues | `node --check` |
| CI automation | Re-run checks on push/PR | GitHub Actions |

## 4. Why this strategy fits the repository

A more advanced stack might include:
- integration tests
- API contract tests
- end-to-end UI tests
- mutation testing
- code coverage tooling

However, those approaches would either:
- require additional packages not allowed by the brief
- rely on infrastructure not guaranteed to exist
- increase fragility for assessors

The chosen strategy therefore prioritizes repeatability and realism.

## 5. Flutter test evidence

## 5.1 Widget boot flow tests
The main widget test verifies that the app routes correctly after the splash delay depending on stored login state.

### Scenario A: logged out user
Expected behavior:
- app starts
- splash screen shows first
- after initialization, auth screen appears

### Scenario B: logged in user
Expected behavior:
- app starts
- splash screen shows first
- after initialization, main navigation screen appears

### Why this matters
This validates:
- startup initialization
- `SharedPreferences` integration
- route selection logic
- the first critical user journey

### Stability approach
To keep the test deterministic:
- `SharedPreferences.setMockInitialValues` is used
- no live network is required
- no real authentication is required

## 5.2 Provider behavior tests
A provider-focused test should validate behavior such as:
- search filtering by title
- search filtering by artist
- local song insertion using `addSong`
- default/fallback state transitions that do not depend on real HTTP/audio

### Why provider tests matter
The provider is the most important logic layer in the Flutter app. Testing it improves confidence in:
- business logic correctness
- state updates
- filtering behavior
- client resilience independent of backend availability

## 6. Backend verification evidence

## 6.1 Syntax checking
The backend validation in CI uses:
```bash
node --check server.js
```

Where modular backend source exists, CI can also scan `backend/src/**/*.js`.

### Why syntax check is useful
Although it is not a substitute for route-level tests, it still prevents:
- broken commits caused by parse errors
- accidental merge regressions
- invalid JavaScript reaching reviewers

## 6.2 Manual API verification plan
Because no extra testing frameworks were added, route behavior can be demonstrated manually with:
- browser for `GET /api/health`
- browser or curl for `GET /api/songs`
- Postman/curl for authenticated library mutations

Example commands:

```bash
curl http://localhost:3000/api/health
curl http://localhost:3000/api/songs
curl http://localhost:3000/api/library
curl -X POST http://localhost:3000/api/library -H "Content-Type: application/json" -H "Authorization: Bearer dev-token" -d "{"songId":"s1","title":"Midnight Echo"}"
```

### Manual checks to record
- correct status codes
- expected JSON shape
- unauthorized response when token is missing/incorrect
- persistence behavior for library data
- compatibility of `GET /api/songs` with Flutter expectations

## 7. Static analysis evidence

## 7.1 Flutter analyze
Command:
```bash
flutter analyze
```

### Purpose
- catch type issues
- catch unused/invalid imports
- surface lint problems
- improve maintainability

### Assessment relevance
Static analysis demonstrates professional development discipline and supports quality assurance even where runtime tests are limited.

## 8. Continuous integration evidence

The repository includes a GitHub Actions workflow in:
- `.github/workflows/ci.yml`

### CI checks performed
1. checkout source
2. install backend dependencies
3. run Node syntax check
4. install Flutter SDK
5. run `flutter pub get`
6. run `flutter analyze`
7. run `flutter test`

### Value of CI
- ensures repeatable validation
- catches regressions early
- reduces dependence on manual checking
- supports team/branch-based workflows
- provides assessor-visible engineering maturity

## 9. Suggested test case catalogue

The following test catalogue is suitable for coursework reporting.

### 9.1 Functional test cases

| ID | Test case | Method | Expected result |
|---|---|---|---|
| FT-01 | App boot when logged out | Widget test | Auth screen shown after splash |
| FT-02 | App boot when logged in | Widget test | Main screen shown after splash |
| FT-03 | Search by title | Provider test | Matching songs returned |
| FT-04 | Search by artist | Provider test | Matching songs returned |
| FT-05 | Add song locally | Provider test | Song appears in provider list |
| FT-06 | Get all songs from API | Manual/API | Response contains required song fields |
| FT-07 | Get library list | Manual/API | JSON contains `success` and `data` |
| FT-08 | Create library item with valid token | Manual/API | Success response and stored item |
| FT-09 | Create library item without token | Manual/API | Unauthorized response |
| FT-10 | Favorite toggle | Manual/API | Updated favorite state returned |

### 9.2 Non-functional test cases

| ID | Test case | Method | Expected result |
|---|---|---|---|
| NFT-01 | Code quality/linting | Static analysis | No blocking analyzer errors |
| NFT-02 | Backend parse validity | Syntax check | No syntax errors |
| NFT-03 | CI repeatability | GitHub Actions | Workflow passes on clean clone |
| NFT-04 | Basic failure resilience | Manual app test | Flutter fallback data prevents blank experience if API fails |

## 10. Example evidence statements for report writing

The following wording can be adapted into a coursework report:

- "Widget testing was used to verify the application's startup navigation, ensuring that persisted login state correctly determined whether the user reached the authentication screen or the main application shell."
- "Provider-level tests were selected because the provider contains the application's core client-side logic, including search and song list manipulation."
- "Static analysis via `flutter analyze` complemented runtime testing by identifying structural and typing issues early."
- "A lightweight Node syntax check was adopted for the backend to provide automated validation without introducing extra packages or infrastructure dependencies."
- "Continuous integration was configured to automate all baseline checks on Ubuntu, improving repeatability and reducing manual verification effort."

## 11. Risks and testing limitations

### Limitations
- no backend integration test framework has been added
- no true end-to-end mobile automation is present
- no network mocking library has been introduced
- audio playback behavior is difficult to validate deeply without more specialized tooling
- CI does not currently measure code coverage
- performance/load testing is out of scope

### Why these limitations are acceptable
Given the project constraints, the implemented test strategy still provides useful evidence because it validates:
- critical startup behavior
- important provider logic
- general code health
- backend parse integrity
- repeatable automation

## 12. Recommended future testing improvements

If the project is expanded, the next testing steps should be:

1. backend route tests using a lightweight HTTP assertion approach
2. API contract tests for `GET /api/songs`
3. integration tests around provider and mocked HTTP responses
4. error-path tests for backend validation/auth middleware
5. golden tests for key UI screens
6. release build smoke tests
7. optional code coverage reporting in CI

## 13. Test execution commands

### Flutter
```bash
flutter pub get
flutter analyze
flutter test
```

### Backend
```bash
cd backend
npm install
node --check server.js
```

## 14. Conclusion

The Auxistra 2.0 testing approach is intentionally pragmatic. It does not claim exhaustive coverage, but it does provide credible and assessable evidence that:
- the app boots correctly
- the login-state flow is stable
- core provider logic can be validated
- backend JavaScript remains syntactically sound
- automated CI safeguards are in place

For coursework purposes, this balance between practicality, honesty, and automation is a strength rather than a weakness.