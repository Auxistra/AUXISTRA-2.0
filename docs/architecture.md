# AUXISTRA 2.0 Architecture

## 1. Purpose of this document

This document explains the technical architecture of Auxistra 2.0 in an academically useful way. It is intended to support coursework discussion around:
- system decomposition
- design rationale
- maintainability
- security
- deployment readiness
- risks and mitigations

It complements the root `README.md` and should be read as a truthful explanation of the implemented baseline rather than an aspirational sales document.

## 2. System context

Auxistra 2.0 is a client-server application for music browsing and remix-oriented playback experimentation.

### Main actors
- end user using the Flutter app
- local or hosted backend API
- optional future infrastructure such as PostgreSQL, Firebase, Stripe, and cloud storage

### Core interaction flow
1. the user opens the Flutter app
2. the app checks local login state using `SharedPreferences`
3. the app initializes provider-managed state
4. the provider requests song data from the backend
5. the backend responds with JSON
6. the frontend maps the response into Dart model objects
7. playback/search/UI state is managed client-side
8. library operations are performed through REST endpoints

## 3. Architectural style

The project uses a layered architecture with separation between:
- presentation
- state management
- transport/API access
- backend routing
- backend service logic
- persistence

This is appropriate for coursework because it:
- improves readability
- supports independent testing
- reduces coupling
- makes future refactoring easier
- aligns with common software engineering best practice

## 4. Frontend architecture

### 4.1 Main layers
The Flutter application is organized broadly into:

- `lib/main.dart`
  - application bootstrap
  - dependency injection using `provider`
  - login state handoff
- `lib/screens/`
  - presentation layer
  - user-facing pages and navigation
- `lib/providers/`
  - state and business logic coordination
- `lib/models/`
  - data representations
- `lib/theme/`
  - visual consistency
- `lib/widgets/`
  - reusable UI components

### 4.2 State management choice
`provider` is used for state management.

#### Why this choice is reasonable
- already included in project dependencies
- simple to understand for coursework review
- lightweight compared with more complex architectures
- suitable for app-wide playback/search state
- integrates well with `ChangeNotifier`

#### Trade-off
- convenient, but large providers can grow too broad over time
- may become harder to scale than more strictly structured architectures if the app expands significantly

### 4.3 Boot flow
The app startup sequence is:

1. Flutter bindings initialize
2. `SharedPreferences` instance is loaded
3. providers are registered in `MultiProvider`
4. splash screen displays briefly
5. login state determines whether auth or main screen is shown

This design gives a polished startup experience and separates transient initialization from the main navigation experience.

### 4.4 MusicProvider responsibilities
The current provider takes responsibility for:
- fetching songs from the backend
- holding all songs in memory
- managing current song
- search/filter logic
- playback/remix state
- fallback data if the API is unavailable

#### Strength
A single provider makes the baseline app easier to understand.

#### Limitation
It centralizes multiple concerns, so future refactoring could split it into:
- song repository/service
- playback controller
- search view model
- library provider

## 5. Backend architecture

### 5.1 Architectural intent
The backend is being moved away from a single-file style into a modular Express structure. The target structure is:

```text
backend/src/
├── app.js
├── config/
├── middleware/
├── routes/
├── services/
└── utils/
```

This structure supports:
- clearer separation of concerns
- route-level organization
- reusable middleware
- easier testing and maintenance

### 5.2 Key backend components
Expected components include:

- `app.js`
  - Express app assembly
  - middleware and route registration
- `routes/`
  - endpoint definitions
- `services/`
  - business logic and data access
- `middleware/`
  - authentication, logging, not-found, error handling
- `utils/`
  - response helpers and validation
- `server.js`
  - runtime entrypoint only

### 5.3 Persistence strategy
The coursework baseline avoids pretending a production database is active when it is not. For that reason, the active library feature uses:
- in-memory state
- JSON file persistence in `backend/data/library.json`

#### Benefits
- no new packages required
- reproducible for assessors
- simple to demo locally
- avoids hidden infrastructure dependency

#### Limitation
- not suitable for concurrent multi-user production
- no transactional integrity
- limited scalability

### 5.4 Database position
A PostgreSQL schema exists in `backend/schema.sql`, but the current documented baseline treats it as:
- a future-ready artefact
- evidence of planned relational design
- not necessarily integrated into runtime behavior yet

This honest distinction is academically important because it avoids overstating implementation completeness.

## 6. API design decisions

## 6.1 RESTful pattern
The backend follows resource-oriented endpoints such as:
- `/api/health`
- `/api/songs`
- `/api/songs/:id`
- `/api/library`
- `/api/library/:id`

This improves predictability and aligns with standard client-server practices.

## 6.2 Response consistency
A specific integration contract applies:
- `GET /api/songs` must remain compatible with the Flutter client's expected song shape
- library endpoints should return:
  - `success`
  - `data`

This is an example of interface stability: the backend may be refactored internally as long as the client-facing contract is preserved.

## 6.3 Authentication convention
Mutating library routes require:

```http
Authorization: Bearer <token>
```

A simple token model is used via environment variable fallback.

#### Rationale
- sufficient for development/demo protection
- easy to test in Postman/curl
- no need to introduce extra packages

#### Limitation
- not a production-grade identity solution

## 7. Security design

Security has been approached proportionally to the project scope.

### Controls included or expected
- bearer token auth on mutating library routes
- request validation
- structured error handling
- environment-variable-driven configuration
- no fake cloud keys in repository
- controlled static uploads exposure

### Security risks
1. simple shared token can be leaked
2. local preferences are not secure identity storage
3. file-backed persistence is vulnerable to local tampering
4. limited auditability/logging compared with production systems
5. uploads may need stricter validation in future

### Mitigations
- keep demo token only for local/dev use
- move secrets to deployment environment
- upgrade to JWT/Firebase auth in future
- introduce stricter validation and upload filtering
- add HTTPS and reverse proxy controls in deployment

## 8. Reliability and resilience

### Current resilience measures
- Flutter fallback data if song API fails
- backend health endpoint
- centralized backend error handling
- modular separation to reduce accidental breakage
- CI checks to catch syntax/test regressions

### Remaining reliability limitations
- no retry/backoff strategy documented for client networking
- no database-backed durability for library items
- no structured monitoring/alerting in current repo
- audio/network edge cases depend on local environment

## 9. Design rationale summary

| Decision | Reason | Trade-off |
|---|---|---|
| Flutter for frontend | Cross-platform UI and fast development | Larger runtime than some native options |
| Provider for state | Simple and already installed | Can become monolithic |
| Express for backend | Familiar, lightweight, flexible | Requires discipline to stay modular |
| JSON-backed library persistence | Easy local demo without new dependencies | Not scalable for production |
| Bearer token for mutations | Simple protection for coursework scope | Weak compared with real auth |
| CI with analyze/test/syntax check | Low-cost quality gate | Not full end-to-end validation |

## 10. Deployment strategy

This repository does not assume live cloud credentials. Therefore, the deployment section focuses on a realistic strategy rather than pretending a deployment already exists.

### 10.1 Backend deployment options
Suitable targets:
- Render
- Railway
- VPS with PM2
- Azure App Service
- AWS Elastic Beanstalk

### 10.2 Backend deployment steps
1. provision Node runtime
2. set environment variables:
   - `PORT`
   - `NODE_ENV`
   - `API_TOKEN`
3. install dependencies with `npm install`
4. start using `node server.js` or a process manager
5. configure reverse proxy and HTTPS if public
6. persist `backend/data/` appropriately or replace with database storage

### 10.3 Flutter deployment options
- web build for assessor demo
- Android APK for mobile demonstration
- desktop target if needed for local showcase

### 10.4 Production hardening path
- replace JSON persistence with PostgreSQL
- use managed object storage for media
- integrate secure authentication
- add centralized logs/monitoring
- add domain, TLS, and CDN where appropriate

## 11. CI/CD strategy

### Current CI
The GitHub Actions workflow performs:
- backend dependency installation
- Node syntax checks
- Flutter dependency resolution
- `flutter analyze`
- `flutter test`

### Why this is suitable
- lightweight enough for student environments
- prevents obvious regressions
- demonstrates professional workflow practice
- supports evidence for continuous validation

### Future CD possibilities
A future pipeline could:
- build Flutter web artifacts
- package backend for deployment
- publish release bundles
- run deployment only on protected branches/tags

## 12. Risks and mitigations

| Risk | Impact | Likelihood | Mitigation |
|---|---|---:|---|
| API contract changes break Flutter client | High | Medium | Preserve `GET /api/songs` payload and document contract |
| Hardcoded mobile IP causes connectivity issues | Medium | High | Make base URL configurable via env/build config |
| Monolithic provider grows harder to maintain | Medium | Medium | Split provider by concern in future |
| JSON persistence corruption | Medium | Low | Add validation and backups; replace with database later |
| Overstated documentation harms credibility | High | Medium | Keep documentation truthful and version-aligned |
| Missing cloud credentials blocks demo | Medium | High | Support local-first setup and document deployment strategy only |

## 13. Limitations

- some legacy repository documents describe features beyond the currently aligned baseline
- PostgreSQL exists as schema design evidence, not guaranteed active runtime integration
- authentication remains simple and development-oriented
- CI checks correctness at a basic level, not full integration depth
- backend persistence is intentionally lightweight

## 14. Future work

### Architectural improvements
- repository pattern for frontend API access
- split playback and library into separate providers
- stronger DTO validation
- backend integration tests without external dependencies

### Product improvements
- richer remix controls
- uploads and artist workflows
- playlist persistence
- recommendation logic
- real user accounts and profile sync

### Operational improvements
- environment-specific config
- release tagging
- observability dashboard
- rollback-aware deployment pipeline

## 15. Conclusion

The Auxistra 2.0 architecture is appropriate for a coursework full-stack application because it demonstrates:
- clear client-server separation
- practical state management
- maintainable backend modularization
- realistic security boundaries
- deployment awareness
- professional development workflow support

Its greatest strength is not claiming enterprise completeness, but instead showing a coherent, extensible baseline with honest documentation and evidence-based engineering decisions.