# Task List: Phase 5 - Testing & Validation

**Related PRD**: [0001-prd-liu-eee-modernization.md](0001-prd-liu-eee-modernization.md#phase-5-testing--validation-week-3-4)

**Goal**: Create comprehensive test suite covering all REST endpoints, openEHR operations, and integration scenarios to ensure the modernized system works correctly and maintains quality.

**Estimated Effort**: Week 3-4 (40-80 hours)

## Relevant Files

- `src/test/java/se/liu/imt/mi/eee/` - Main test directory structure
- `src/test/java/se/liu/imt/mi/eee/rest/` - REST endpoint tests (to be created)
- `src/test/java/se/liu/imt/mi/eee/openehr/` - openEHR operation tests (to be created)
- `src/test/java/se/liu/imt/mi/eee/integration/` - Integration tests (to be created)
- `src/test/java/se/liu/imt/mi/eee/performance/` - Performance tests (to be created)
- `src/test/resources/` - Test resources (sample archetypes, compositions, test data)
- `src/test/resources/test-application.properties` - Test configuration
- `pom.xml` - Test dependencies configuration
- Test documentation files

### Notes

- Use JUnit 5 (Jupiter) for all new tests
- Use REST Assured for REST endpoint testing
- Use Quarkus test framework (@QuarkusTest) for integration tests
- Use Testcontainers for database testing if applicable
- Aim for >70% code coverage for core functionality
- Focus on critical paths and regression prevention
- Performance tests should establish baseline metrics
- Tests serve as documentation and examples

## Tasks

- [ ] 1.0 Set Up Testing Infrastructure
  - [ ] 1.1 Verify JUnit 5 (Jupiter) dependency in pom.xml
  - [ ] 1.2 Add quarkus-junit5 dependency for Quarkus testing
  - [ ] 1.3 Add rest-assured dependency for REST testing
  - [ ] 1.4 Add mockito-core for mocking if needed
  - [ ] 1.5 Add assertj-core for fluent assertions (optional but recommended)
  - [ ] 1.6 Add testcontainers dependencies if using containers for tests
  - [ ] 1.7 Update maven-surefire-plugin to latest version (3.2.0+)
  - [ ] 1.8 Configure test execution in pom.xml (parallel execution, etc.)
  - [ ] 1.9 Create test directory structure
  - [ ] 1.10 Create test base classes and utilities

- [ ] 2.0 Create Test Configuration
  - [ ] 2.1 Create `src/test/resources/application.properties` for test config
  - [ ] 2.2 Configure test database (in-memory or Testcontainer)
  - [ ] 2.3 Configure test ports (avoid conflicts with dev server)
  - [ ] 2.4 Configure test logging levels
  - [ ] 2.5 Create test data directory structure
  - [ ] 2.6 Set up test archetype repository with sample archetypes
  - [ ] 2.7 Create sample composition files for testing
  - [ ] 2.8 Configure test security (test users, credentials)

- [ ] 3.0 Create REST Endpoint Test Base Classes
  - [ ] 3.1 Create `RestTestBase.java` with common REST test setup
  - [ ] 3.2 Configure REST Assured base URI and port
  - [ ] 3.3 Create authentication helper methods
  - [ ] 3.4 Create request builder helper methods
  - [ ] 3.5 Create response validation helper methods
  - [ ] 3.6 Create test data creation utilities
  - [ ] 3.7 Create cleanup utilities (after each test)
  - [ ] 3.8 Document test base class usage

- [ ] 4.0 Test EHR REST Endpoints
  - [ ] 4.1 Create `EHRResourceTest.java` for EHR root operations
  - [ ] 4.2 Test EHR creation (POST /ehr)
  - [ ] 4.3 Test EHR retrieval by ID (GET /ehr/{ehrId})
  - [ ] 4.4 Test EHR listing (GET /ehr)
  - [ ] 4.5 Test EHR not found scenario (404)
  - [ ] 4.6 Test EHR invalid ID scenario (400)
  - [ ] 4.7 Create `ContributionResourceTest.java`
  - [ ] 4.8 Test contribution creation (POST /ehr/{ehrId}/contribution)
  - [ ] 4.9 Test contribution retrieval (GET /ehr/{ehrId}/contribution/{contributionId})
  - [ ] 4.10 Test contribution listing (GET /ehr/{ehrId}/contribution)
  - [ ] 4.11 Test latest contribution retrieval
  - [ ] 4.12 Create `VersionedObjectResourceTest.java`
  - [ ] 4.13 Test versioned object creation
  - [ ] 4.14 Test versioned object retrieval (latest and specific version)
  - [ ] 4.15 Test versioned object update
  - [ ] 4.16 Test version history listing
  - [ ] 4.17 Verify all EHR endpoints return correct HTTP status codes
  - [ ] 4.18 Verify all EHR endpoints handle authentication correctly

- [ ] 5.0 Test Query REST Endpoints
  - [ ] 5.1 Create `QueryResourceTest.java`
  - [ ] 5.2 Test AQL query execution (POST /query with AQL body)
  - [ ] 5.3 Test query results format (JSON/XML)
  - [ ] 5.4 Test query with no results
  - [ ] 5.5 Test query with invalid syntax (400 error)
  - [ ] 5.6 Test multi-query execution
  - [ ] 5.7 Create `StoredQueryResourceTest.java`
  - [ ] 5.8 Test stored query creation (POST /query/stored)
  - [ ] 5.9 Test stored query retrieval (GET /query/stored/{queryId})
  - [ ] 5.10 Test stored query execution
  - [ ] 5.11 Test stored query listing
  - [ ] 5.12 Test stored query deletion
  - [ ] 5.13 Test query timeout handling
  - [ ] 5.14 Test query parameter binding

- [ ] 6.0 Test Contribution Builder REST Endpoints
  - [ ] 6.1 Create `ContributionBuilderResourceTest.java`
  - [ ] 6.2 Test contribution builder initialization (POST /cb/init)
  - [ ] 6.3 Test adding objects to builder (POST /cb/{builderId}/object)
  - [ ] 6.4 Test updating object data in builder
  - [ ] 6.5 Test contribution validation (POST /cb/{builderId}/validate)
  - [ ] 6.6 Test contribution commit (POST /cb/{builderId}/commit)
  - [ ] 6.7 Test combined validate-and-commit
  - [ ] 6.8 Test builder listing
  - [ ] 6.9 Test builder timeout/cleanup
  - [ ] 6.10 Test multi-step builder workflow end-to-end
  - [ ] 6.11 Test concurrent builders for different users
  - [ ] 6.12 Verify builder state isolation between users

- [ ] 7.0 Test Bookmark REST Endpoints
  - [ ] 7.1 Create `BookmarkResourceTest.java`
  - [ ] 7.2 Test bookmark creation (POST /bookmark)
  - [ ] 7.3 Test bookmark retrieval (GET /bookmark/{bookmarkId})
  - [ ] 7.4 Test bookmark listing for user (GET /bookmark/user/{userId})
  - [ ] 7.5 Test bookmark resolution
  - [ ] 7.6 Test bookmark editing (PUT /bookmark/{bookmarkId})
  - [ ] 7.7 Test bookmark deletion (DELETE /bookmark/{bookmarkId})
  - [ ] 7.8 Test bookmark not found (404)
  - [ ] 7.9 Verify user isolation (user A cannot access user B's bookmarks)

- [ ] 8.0 Test Utility and Support Endpoints
  - [ ] 8.1 Test health check endpoint (GET /q/health)
  - [ ] 8.2 Test readiness probe
  - [ ] 8.3 Test liveness probe
  - [ ] 8.4 Test OpenAPI endpoint (GET /q/openapi)
  - [ ] 8.5 Test utility endpoints (hash, trace, etc.)
  - [ ] 8.6 Test database time endpoint
  - [ ] 8.7 Test static file serving (GET /static/...)

- [ ] 9.0 Test Content Negotiation
  - [ ] 9.1 Test JSON response (Accept: application/json)
  - [ ] 9.2 Test XML response (Accept: application/xml)
  - [ ] 9.3 Test default content type
  - [ ] 9.4 Test unsupported content type (406)
  - [ ] 9.5 Test JSON request body parsing (Content-Type: application/json)
  - [ ] 9.6 Test XML request body parsing (Content-Type: application/xml)
  - [ ] 9.7 Verify content negotiation works for all endpoints

- [ ] 10.0 Test Authentication and Authorization
  - [ ] 10.1 Test public endpoints (no authentication required)
  - [ ] 10.2 Test protected endpoints without credentials (401)
  - [ ] 10.3 Test protected endpoints with invalid credentials (401)
  - [ ] 10.4 Test protected endpoints with valid credentials (200)
  - [ ] 10.5 Test role-based access control if implemented
  - [ ] 10.6 Test session management if applicable
  - [ ] 10.7 Verify security headers in responses

- [ ] 11.0 Test Error Handling
  - [ ] 11.1 Test 400 Bad Request scenarios (invalid input)
  - [ ] 11.2 Test 401 Unauthorized scenarios
  - [ ] 11.3 Test 404 Not Found scenarios
  - [ ] 11.4 Test 405 Method Not Allowed scenarios
  - [ ] 11.5 Test 409 Conflict scenarios
  - [ ] 11.6 Test 500 Internal Server Error scenarios
  - [ ] 11.7 Verify error response format is consistent
  - [ ] 11.8 Verify error messages are helpful and informative
  - [ ] 11.9 Verify stack traces are not exposed in production mode

- [ ] 12.0 Test Archetype Operations
  - [ ] 12.1 Create `ArchetypeParsingTest.java`
  - [ ] 12.2 Test parsing ADL 1.4 archetypes
  - [ ] 12.3 Test parsing ADL 2.0 archetypes
  - [ ] 12.4 Test archetype validation (valid archetypes)
  - [ ] 12.5 Test archetype validation (invalid archetypes with errors)
  - [ ] 12.6 Test archetype ontology access
  - [ ] 12.7 Test archetype constraint model traversal
  - [ ] 12.8 Create `ArchetypeRepositoryTest.java`
  - [ ] 12.9 Test archetype loading from filesystem
  - [ ] 12.10 Test archetype lookup by ID
  - [ ] 12.11 Test archetype caching
  - [ ] 12.12 Test archetype reload/refresh

- [ ] 13.0 Test Template Operations
  - [ ] 13.1 Create `TemplateFlattenerTest.java`
  - [ ] 13.2 Test template loading (OET files)
  - [ ] 13.3 Test template flattening
  - [ ] 13.4 Test operational template generation
  - [ ] 13.5 Test template constraint resolution
  - [ ] 13.6 Test template terminology binding
  - [ ] 13.7 Test flattened template validation
  - [ ] 13.8 Test template caching

- [ ] 14.0 Test Composition Creation and Validation
  - [ ] 14.1 Create `CompositionCreationTest.java`
  - [ ] 14.2 Test creating composition programmatically using Archie RM
  - [ ] 14.3 Test composition with various data types (DvText, DvCodedText, DvQuantity, etc.)
  - [ ] 14.4 Test composition with nested structures
  - [ ] 14.5 Create `CompositionValidationTest.java`
  - [ ] 14.6 Test composition validation against archetype (valid composition)
  - [ ] 14.7 Test validation failures (missing required fields)
  - [ ] 14.8 Test validation failures (type mismatches)
  - [ ] 14.9 Test validation failures (constraint violations)
  - [ ] 14.10 Test validation error reporting

- [ ] 15.0 Test Serialization and Deserialization
  - [ ] 15.1 Create `SerializationTest.java`
  - [ ] 15.2 Test composition to JSON serialization
  - [ ] 15.3 Test JSON to composition deserialization
  - [ ] 15.4 Test composition to XML serialization
  - [ ] 15.5 Test XML to composition deserialization
  - [ ] 15.6 Test round-trip JSON (composition → JSON → composition)
  - [ ] 15.7 Test round-trip XML (composition → XML → composition)
  - [ ] 15.8 Verify serialized format compatibility with stored data
  - [ ] 15.9 Test serialization of all RM data types
  - [ ] 15.10 Test handling of null and optional fields

- [ ] 16.0 Test Database Operations
  - [ ] 16.1 Create `DatabaseIntegrationTest.java` with @QuarkusTest
  - [ ] 16.2 Test database connection establishment
  - [ ] 16.3 Test collection creation
  - [ ] 16.4 Test document storage
  - [ ] 16.5 Test document retrieval
  - [ ] 16.6 Test document update
  - [ ] 16.7 Test document deletion
  - [ ] 16.8 Test XQuery execution
  - [ ] 16.9 Test transaction commit
  - [ ] 16.10 Test transaction rollback
  - [ ] 16.11 Test concurrent database access
  - [ ] 16.12 Verify data persistence across test runs

- [ ] 17.0 Test AQL Query Translation and Execution
  - [ ] 17.1 Create `AQLQueryTest.java`
  - [ ] 17.2 Test AQL parsing (valid queries)
  - [ ] 17.3 Test AQL parsing errors (invalid syntax)
  - [ ] 17.4 Test AQL to XQuery translation for simple queries
  - [ ] 17.5 Test translation for complex queries (joins, WHERE clauses)
  - [ ] 17.6 Test translation for aggregation queries (COUNT, SUM, etc.)
  - [ ] 17.7 Test query execution on sample data
  - [ ] 17.8 Verify query results format
  - [ ] 17.9 Test query with no results
  - [ ] 17.10 Test query performance with indexed data

- [ ] 18.0 Integration Testing - Complete Workflows
  - [ ] 18.1 Create `EHRWorkflowIntegrationTest.java`
  - [ ] 18.2 Test complete workflow: create EHR → add composition → query → retrieve
  - [ ] 18.3 Test workflow: create contribution with multiple compositions
  - [ ] 18.4 Test workflow: contribution builder multi-step process
  - [ ] 18.5 Test workflow: create bookmark → resolve → edit → delete
  - [ ] 18.6 Test workflow: store query → execute stored query
  - [ ] 18.7 Test workflow: versioned object lifecycle (create → update → retrieve versions)
  - [ ] 18.8 Verify end-to-end data integrity
  - [ ] 18.9 Test error handling in workflows (partial failures)

- [ ] 19.0 Performance Testing
  - [ ] 19.1 Create `PerformanceTest.java` (may need separate profile)
  - [ ] 19.2 Benchmark simple GET request (<200ms target)
  - [ ] 19.3 Benchmark composition creation (<500ms target)
  - [ ] 19.4 Benchmark composition retrieval
  - [ ] 19.5 Benchmark AQL query execution (<1s target)
  - [ ] 19.6 Benchmark archetype loading and parsing
  - [ ] 19.7 Benchmark template flattening
  - [ ] 19.8 Test concurrent request handling (50+ concurrent users)
  - [ ] 19.9 Test system under load (sustained high throughput)
  - [ ] 19.10 Identify performance bottlenecks
  - [ ] 19.11 Compare with baseline metrics (if available)
  - [ ] 19.12 Document performance test results

- [ ] 20.0 Load and Stress Testing
  - [ ] 20.1 Create load testing scenarios (JMeter or Gatling)
  - [ ] 20.2 Test sustained load (100 requests/sec for 5 minutes)
  - [ ] 20.3 Test spike load (sudden traffic increase)
  - [ ] 20.4 Test memory usage under load
  - [ ] 20.5 Test database connection pool under load
  - [ ] 20.6 Monitor response times under load
  - [ ] 20.7 Identify system limits (max throughput, max users)
  - [ ] 20.8 Test recovery after stress
  - [ ] 20.9 Document load testing results and system capacity

- [ ] 21.0 Code Coverage Analysis
  - [ ] 21.1 Configure JaCoCo Maven plugin for coverage reporting
  - [ ] 21.2 Run all tests and generate coverage report
  - [ ] 21.3 Review coverage report (aim for >70% overall)
  - [ ] 21.4 Identify critical paths with low coverage
  - [ ] 21.5 Write additional tests for low-coverage areas
  - [ ] 21.6 Review coverage for each package
  - [ ] 21.7 Set minimum coverage thresholds
  - [ ] 21.8 Configure CI to enforce coverage requirements
  - [ ] 21.9 Document coverage results and goals

- [ ] 22.0 Regression Testing
  - [ ] 22.1 Identify all existing functionality to preserve
  - [ ] 22.2 Create regression test suite for critical features
  - [ ] 22.3 Test backward compatibility with existing data
  - [ ] 22.4 Test API compatibility with previous version
  - [ ] 22.5 Verify no functionality was lost in migration
  - [ ] 22.6 Document any intentional breaking changes
  - [ ] 22.7 Create test matrix for regression scenarios

- [ ] 23.0 Security Testing
  - [ ] 23.1 Test authentication bypass attempts
  - [ ] 23.2 Test authorization bypass attempts
  - [ ] 23.3 Test SQL/XQuery injection vulnerabilities
  - [ ] 23.4 Test XSS vulnerabilities in UI
  - [ ] 23.5 Test CSRF protection if applicable
  - [ ] 23.6 Test secure headers (CSP, HSTS, etc.)
  - [ ] 23.7 Verify sensitive data is not logged
  - [ ] 23.8 Test rate limiting if implemented
  - [ ] 23.9 Run OWASP dependency check
  - [ ] 23.10 Document security test results

- [ ] 24.0 Test Documentation
  - [ ] 24.1 Document test strategy and approach
  - [ ] 24.2 Document test coverage goals
  - [ ] 24.3 Create test execution guide
  - [ ] 24.4 Document how to run specific test categories
  - [ ] 24.5 Document test data setup and cleanup
  - [ ] 24.6 Create troubleshooting guide for test failures
  - [ ] 24.7 Document performance baselines
  - [ ] 24.8 Create examples of common test patterns

- [ ] 25.0 Final Test Execution and Reporting
  - [ ] 25.1 Run complete test suite (`mvn clean verify`)
  - [ ] 25.2 Ensure all unit tests pass
  - [ ] 25.3 Ensure all integration tests pass
  - [ ] 25.4 Ensure all performance tests meet targets
  - [ ] 25.5 Review test execution logs for warnings/errors
  - [ ] 25.6 Generate comprehensive test report
  - [ ] 25.7 Document any known test failures or limitations
  - [ ] 25.8 Create test result summary for stakeholders
  - [ ] 25.9 Archive test reports for future reference
  - [ ] 25.10 Update README with test execution instructions

## Acceptance Criteria

- [ ] >70% code coverage for core functionality
- [ ] All REST endpoint tests passing
- [ ] All openEHR operation tests passing
- [ ] All integration tests passing
- [ ] Performance targets met (response times, throughput)
- [ ] Load testing completed and capacity documented
- [ ] No critical security vulnerabilities
- [ ] Regression tests confirm no functionality lost
- [ ] Test documentation complete
- [ ] CI can run full test suite successfully

## Dependencies

**Blocks**:
- Phase 6: Documentation & Deployment (testing validates system is ready)

**Prerequisites**:
- Phase 1: Foundation & Build System (test infrastructure dependencies)
- Phase 2: openEHR Library Migration (testing requires working openEHR integration)
- Phase 3: REST Framework Migration (testing REST endpoints)
- Phase 4: Database Layer Updates (testing database operations)

## Notes

- Testing is critical for confidence in the modernization
- Tests serve as documentation and usage examples
- Invest in good test infrastructure - it pays off
- Use Quarkus test framework for fast feedback
- Consider test-driven development (TDD) for new features
- Keep tests maintainable - avoid duplication, use helpers
- Run tests frequently during development
- Fix broken tests immediately - don't let them accumulate
- Performance tests should run on consistent hardware for meaningful comparisons
- Consider separate test profiles (unit, integration, performance)
- Use Testcontainers for isolated database testing
- Mock external dependencies to keep tests fast and reliable
- Document how to debug failing tests
- Consider continuous testing in CI pipeline
