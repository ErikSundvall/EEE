# Task List: Phase 3 - REST Framework Migration

**Related PRD**: [0001-prd-liu-eee-modernization.md](0001-prd-liu-eee-modernization.md#phase-3-rest-framework-migration-week-2-3)

**Goal**: Migrate from Restlet framework to Quarkus JAX-RS, converting all REST endpoints while preserving API compatibility and functionality.

**Estimated Effort**: Week 2-3 (80 hours)

## Relevant Files

- `src/main/java/se/liu/imt/mi/eee/DemoStarter.java` - Main application entry point using Restlet Component
- `src/main/java/se/liu/imt/mi/eee/ehr/res/*.java` - 9 EHR resource classes (ContributionResource, VersionedObjectResource, etc.)
- `src/main/java/se/liu/imt/mi/eee/cb/res/*.java` - 7 Contribution Builder resource classes
- `src/main/java/se/liu/imt/mi/eee/bm/res/*.java` - 5 Bookmark resource classes
- Router classes in various packages - Need conversion to JAX-RS path hierarchies
- `src/main/resources/templates/` - Freemarker templates (to be converted to Qute)
- `src/main/resources/www-static/` - Static web content (to be moved to META-INF/resources/)
- Authentication/security classes using Restlet ChallengeAuthenticator
- `src/main/java/se/liu/imt/mi/eee/QuarkusApplication.java` - New Quarkus application class (to be created)
- Test files for REST endpoints (to be updated for REST Assured)

### Notes

- JAX-RS is standards-based; most Restlet patterns map cleanly
- Quarkus uses annotations (@GET, @POST, @Path) instead of Restlet's routing
- Response objects become return values; Quarkus handles serialization automatically
- Static file serving in Quarkus uses `src/main/resources/META-INF/resources/`
- Qute is Quarkus's native templating engine, similar to Freemarker
- REST Assured provides excellent testing support for JAX-RS endpoints
- OpenAPI/Swagger replaces WADL for API documentation

## Tasks

- [ ] 1.0 Create Quarkus Application Infrastructure
  - [ ] 1.1 Create `src/main/java/se/liu/imt/mi/eee/QuarkusApplication.java`
  - [ ] 1.2 Annotate with `@ApplicationPath` to set REST API base path
  - [ ] 1.3 Configure CDI application scope if needed
  - [ ] 1.4 Set up lifecycle events (startup, shutdown) migrating from Restlet Component lifecycle
  - [ ] 1.5 Configure CORS settings in application.properties if needed
  - [ ] 1.6 Remove Restlet Component initialization from DemoStarter
  - [ ] 1.7 Update DemoStarter to use Quarkus.run() or remove if no longer needed

- [ ] 2.0 Analyze Existing REST API Structure
  - [ ] 2.1 Document all Restlet ServerResource classes and their endpoints
  - [ ] 2.2 Document router hierarchy and URL patterns
  - [ ] 2.3 Map HTTP methods used (GET, POST, PUT, DELETE, OPTIONS)
  - [ ] 2.4 Document request/response content types (JSON, XML, HTML)
  - [ ] 2.5 Document query parameters and path variables used
  - [ ] 2.6 Document authentication/authorization requirements per endpoint
  - [ ] 2.7 Create endpoint inventory spreadsheet for tracking migration
  - [ ] 2.8 Identify WADL usage and plan OpenAPI replacement

- [ ] 3.0 Convert EHR Resources Package
  - [ ] 3.1 Convert `EHRRoot.java` from ServerResource to JAX-RS resource
  - [ ] 3.2 Convert `ContributionResource.java` - handle GET/POST/PUT/DELETE for contributions
  - [ ] 3.3 Convert `ContributionLatestResource.java` - get latest contribution
  - [ ] 3.4 Convert `ContributionListingResource.java` - list contributions for an EHR
  - [ ] 3.5 Convert `VersionedObjectResource.java` - manage versioned EHR objects
  - [ ] 3.6 Convert `VersionedObjectCommandResource.java` - commands on versioned objects
  - [ ] 3.7 Convert `IdentifiedEHR.java` - EHR identification operations
  - [ ] 3.8 Convert `Query.java` - AQL query execution endpoint
  - [ ] 3.9 Convert `MultiQuery.java` - batch query operations
  - [ ] 3.10 Convert `StoredQuery.java` - stored query management
  - [ ] 3.11 Convert `StoredQueryAQL.java` - AQL-specific stored queries
  - [ ] 3.12 Convert `StoredQueryXQueryAQLHybrid.java` - hybrid query execution
  - [ ] 3.13 Convert `StoredQueryInfo.java` - query metadata endpoint
  - [ ] 3.14 Convert `CurrentDatabaseTimeResource.java` - utility endpoint for DB time
  - [ ] 3.15 Ensure all path parameters use JAX-RS @PathParam annotation
  - [ ] 3.16 Ensure all query parameters use JAX-RS @QueryParam annotation

- [ ] 4.0 Convert Contribution Builder Resources Package
  - [ ] 4.1 Convert `ContributionBuilderInitiatorResource.java` - initialize contribution builder
  - [ ] 4.2 Convert `ContributionBuilderListResource.java` - list active contribution builders
  - [ ] 4.3 Convert `ContributionBuilderObjectResource.java` - manage objects in builder
  - [ ] 4.4 Convert `ContributionBuilderObjectDataResource.java` - object data operations
  - [ ] 4.5 Convert `ContributionBuilderValidate.java` - validate contribution before commit
  - [ ] 4.6 Convert `ContributionBuilderCommit.java` - commit contribution to database
  - [ ] 4.7 Convert `ContributionBuilderValidateAndCommit.java` - combined validate and commit
  - [ ] 4.8 Ensure multi-step builder workflow is preserved
  - [ ] 4.9 Maintain session/state management for builder (use CDI @SessionScoped if needed)

- [ ] 5.0 Convert Bookmark Resources Package
  - [ ] 5.1 Convert `BookmarkPrefixedRoot.java` - bookmark root endpoint
  - [ ] 5.2 Convert `BookmarkInfo.java` - bookmark information endpoint
  - [ ] 5.3 Convert `BookmarkListOfUser.java` - list bookmarks for a user
  - [ ] 5.4 Convert `BookmarkQR.java` - bookmark query/retrieval operations
  - [ ] 5.5 Convert `BookmarkResolveOrEdit.java` - resolve or edit bookmark
  - [ ] 5.6 Preserve bookmark CRUD operations
  - [ ] 5.7 Maintain user-specific bookmark isolation

- [ ] 6.0 Convert Utility Resources
  - [ ] 6.1 Identify and convert HashUtilResource if it exists (hashing utilities)
  - [ ] 6.2 Identify and convert TraceResource if it exists (debugging/tracing)
  - [ ] 6.3 Convert any health check or monitoring resources
  - [ ] 6.4 Convert any documentation serving resources
  - [ ] 6.5 Ensure utility endpoints maintain backward compatibility

- [ ] 7.0 Implement Request/Response Handling
  - [ ] 7.1 Replace Restlet Representation with JAX-RS Response and entity objects
  - [ ] 7.2 Create POJO classes for JSON request/response bodies
  - [ ] 7.3 Configure Jackson for JSON serialization (via quarkus-resteasy-reactive-jackson)
  - [ ] 7.4 Configure JAXB for XML serialization (via quarkus-resteasy-reactive-jaxb)
  - [ ] 7.5 Implement content negotiation using @Produces and @Consumes annotations
  - [ ] 7.6 Handle multipart form data if used (file uploads)
  - [ ] 7.7 Implement proper HTTP status code responses (Response.status(...))
  - [ ] 7.8 Add proper error response objects with consistent structure

- [ ] 8.0 Implement Routing and Path Hierarchies
  - [ ] 8.1 Replace Restlet Router classes with JAX-RS @Path hierarchies
  - [ ] 8.2 Use path templates for dynamic segments (e.g., @Path("/ehr/{ehrId}"))
  - [ ] 8.3 Implement sub-resource locators where needed (@Path on methods)
  - [ ] 8.4 Preserve URL structure from Restlet implementation
  - [ ] 8.5 Test that all original endpoint URLs still work
  - [ ] 8.6 Document any URL changes (if unavoidable) in migration guide

- [ ] 9.0 Migrate Static File Serving
  - [ ] 9.1 Move `src/main/resources/www-static/` to `src/main/resources/META-INF/resources/`
  - [ ] 9.2 Configure Quarkus static resource serving in application.properties
  - [ ] 9.3 Test that all static files (HTML, CSS, JS, images) are accessible
  - [ ] 9.4 Preserve directory structure and file organization
  - [ ] 9.5 Update any hardcoded paths in HTML/JS files
  - [ ] 9.6 Test D3.js visualizations still work
  - [ ] 9.7 Test documentation pages are accessible

- [ ] 10.0 Migrate Templating from Freemarker to Qute
  - [ ] 10.1 Identify all Freemarker template files (*.ftl)
  - [ ] 10.2 Create equivalent Qute templates in `src/main/resources/templates/`
  - [ ] 10.3 Convert Freemarker syntax to Qute syntax (similar but some differences)
  - [ ] 10.4 Update template variable passing to use Qute API
  - [ ] 10.5 Replace TemplateRepresentation with Qute Template injection
  - [ ] 10.6 Test all template rendering with sample data
  - [ ] 10.7 Verify HTML output is identical or equivalent
  - [ ] 10.8 Handle template errors gracefully

- [ ] 11.0 Implement Authentication and Security
  - [ ] 11.1 Analyze current Restlet ChallengeAuthenticator usage
  - [ ] 11.2 Configure Quarkus Security (basic auth for now)
  - [ ] 11.3 Create `application.properties` security configuration
  - [ ] 11.4 Implement user verification with MapVerifier equivalent
  - [ ] 11.5 Use @RolesAllowed annotation for protected endpoints
  - [ ] 11.6 Use @PermitAll for public endpoints
  - [ ] 11.7 Implement SecurityContext injection for user info
  - [ ] 11.8 Test authentication with valid credentials
  - [ ] 11.9 Test authentication rejection with invalid credentials
  - [ ] 11.10 Document authentication configuration for deployment

- [ ] 12.0 Implement Error Handling and Exception Mapping
  - [ ] 12.1 Create custom exception classes for business logic errors
  - [ ] 12.2 Create JAX-RS ExceptionMapper classes for exception types
  - [ ] 12.3 Map exceptions to appropriate HTTP status codes (400, 404, 500, etc.)
  - [ ] 12.4 Create consistent error response format (JSON/XML)
  - [ ] 12.5 Include error details, messages, and codes in responses
  - [ ] 12.6 Log errors appropriately (stack traces for 500s, messages for 400s)
  - [ ] 12.7 Test error responses for various error scenarios
  - [ ] 12.8 Preserve error handling behavior from Restlet implementation

- [ ] 13.0 Update Database Integration Layer
  - [ ] 13.1 Review database access patterns in resource classes
  - [ ] 13.2 Inject database services using CDI (@Inject)
  - [ ] 13.3 Remove manual service instantiation/lookup
  - [ ] 13.4 Implement proper transaction boundaries if needed
  - [ ] 13.5 Test database operations from all converted endpoints
  - [ ] 13.6 Verify database connections are properly managed

- [ ] 14.0 Generate OpenAPI Documentation
  - [ ] 14.1 Add `quarkus-smallrye-openapi` extension to pom.xml
  - [ ] 14.2 Annotate resources with OpenAPI annotations (@Operation, @Tag, etc.)
  - [ ] 14.3 Document all endpoints with descriptions
  - [ ] 14.4 Document request/response schemas
  - [ ] 14.5 Document query parameters and path parameters
  - [ ] 14.6 Document authentication requirements
  - [ ] 14.7 Configure OpenAPI metadata (title, version, description)
  - [ ] 14.8 Access Swagger UI at `/q/swagger-ui` and verify
  - [ ] 14.9 Export OpenAPI spec and compare with old WADL (conceptually)
  - [ ] 14.10 Update API documentation references to use OpenAPI instead of WADL

- [ ] 15.0 Implement Health Checks and Monitoring
  - [ ] 15.1 Add `quarkus-smallrye-health` extension
  - [ ] 15.2 Implement liveness probe (is app running?)
  - [ ] 15.3 Implement readiness probe (is app ready to serve requests?)
  - [ ] 15.4 Add health check for database connectivity
  - [ ] 15.5 Add health check for archetype repository initialization
  - [ ] 15.6 Access health endpoint at `/q/health` and verify
  - [ ] 15.7 Document health check endpoints for monitoring

- [ ] 16.0 Test REST Endpoints with REST Assured
  - [ ] 16.1 Set up REST Assured test dependencies
  - [ ] 16.2 Create test base class with common setup
  - [ ] 16.3 Write tests for EHR resource endpoints (CRUD operations)
  - [ ] 16.4 Write tests for contribution builder workflow
  - [ ] 16.5 Write tests for bookmark operations
  - [ ] 16.6 Write tests for query execution
  - [ ] 16.7 Write tests for authentication (authorized and unauthorized)
  - [ ] 16.8 Write tests for error cases (404, 400, 500)
  - [ ] 16.9 Write tests for content negotiation (JSON and XML)
  - [ ] 16.10 Ensure all tests pass with Quarkus test runner

- [ ] 17.0 Configure Quarkus Dev Mode
  - [ ] 17.1 Configure hot reload for Java classes
  - [ ] 17.2 Configure hot reload for templates
  - [ ] 17.3 Configure hot reload for static resources
  - [ ] 17.4 Set up dev services for database if applicable
  - [ ] 17.5 Test that code changes trigger automatic rebuild
  - [ ] 17.6 Configure dev UI access at `/q/dev`
  - [ ] 17.7 Document dev mode usage for developers

- [ ] 18.0 Handle Session State and Contribution Builder
  - [ ] 18.1 Analyze contribution builder's state management needs
  - [ ] 18.2 Decide on state storage (in-memory, database, Redis)
  - [ ] 18.3 Implement contribution builder session storage
  - [ ] 18.4 Use @SessionScoped or @ApplicationScoped beans appropriately
  - [ ] 18.5 Ensure builder state persists across requests
  - [ ] 18.6 Implement timeout/cleanup for abandoned builders
  - [ ] 18.7 Test multi-step contribution builder workflow
  - [ ] 18.8 Test concurrent contribution builders for different users

- [ ] 19.0 Verify API Compatibility
  - [ ] 19.1 Test all original endpoint URLs respond correctly
  - [ ] 19.2 Test all HTTP methods (GET, POST, PUT, DELETE)
  - [ ] 19.3 Verify query parameters work as expected
  - [ ] 19.4 Verify path parameters work as expected
  - [ ] 19.5 Test request body parsing (JSON and XML)
  - [ ] 19.6 Test response serialization (JSON and XML)
  - [ ] 19.7 Compare response formats with Restlet baseline (if available)
  - [ ] 19.8 Document any breaking changes in migration guide

- [ ] 20.0 Performance Testing
  - [ ] 20.1 Benchmark simple GET request response time
  - [ ] 20.2 Benchmark composition creation (POST) response time
  - [ ] 20.3 Benchmark query execution response time
  - [ ] 20.4 Test concurrent request handling (50+ users)
  - [ ] 20.5 Compare performance with Restlet baseline if available
  - [ ] 20.6 Profile memory usage under load
  - [ ] 20.7 Identify and fix performance bottlenecks
  - [ ] 20.8 Document performance characteristics

- [ ] 21.0 Update Configuration Management
  - [ ] 21.1 Move all configuration to `application.properties`
  - [ ] 21.2 Create dev profile configuration (application-dev.properties)
  - [ ] 21.3 Create test profile configuration (application-test.properties)
  - [ ] 21.4 Create prod profile configuration (application-prod.properties)
  - [ ] 21.5 Configure database connections per profile
  - [ ] 21.6 Configure security settings per profile
  - [ ] 21.7 Configure logging levels per profile
  - [ ] 21.8 Document all configuration options

- [ ] 22.0 Clean Up Deprecated Code
  - [ ] 22.1 Remove all Restlet imports from active code
  - [ ] 22.2 Delete or move Restlet classes to defunct/ directory
  - [ ] 22.3 Remove Restlet router classes
  - [ ] 22.4 Clean up any Restlet utility classes
  - [ ] 22.5 Update code comments removing Restlet references
  - [ ] 22.6 Verify no Restlet dependencies remain in runtime classpath

- [ ] 23.0 Final Integration Testing
  - [ ] 23.1 Start application in dev mode (`mvn quarkus:dev`)
  - [ ] 23.2 Test complete EHR workflow (create EHR, add composition, query)
  - [ ] 23.3 Test complete contribution builder workflow
  - [ ] 23.4 Test bookmark creation and retrieval
  - [ ] 23.5 Test static web UI functionality
  - [ ] 23.6 Test template rendering
  - [ ] 23.7 Test authentication and authorization
  - [ ] 23.8 Verify OpenAPI documentation is accessible
  - [ ] 23.9 Verify health checks work
  - [ ] 23.10 Run full regression test suite

## Acceptance Criteria

- [ ] All Restlet ServerResource classes converted to JAX-RS resources
- [ ] All REST endpoints accessible and functional
- [ ] API URLs preserved (or breaking changes documented)
- [ ] JSON and XML content negotiation working
- [ ] Static files served correctly
- [ ] Templates render correctly with Qute
- [ ] Authentication and authorization working
- [ ] OpenAPI documentation complete and accessible
- [ ] All REST endpoint tests passing
- [ ] No Restlet dependencies in runtime classpath
- [ ] Performance meets or exceeds baseline
- [ ] Dev mode hot reload working

## Dependencies

**Blocks**:
- Phase 5: Testing & Validation (needs working REST API)
- Phase 6: Documentation & Deployment (needs complete REST API)

**Prerequisites**:
- Phase 1: Foundation & Build System (Quarkus dependencies must be available)
- Phase 2: openEHR Library Migration (REST resources use openEHR classes)

## Notes

- This is the most visible migration - REST API compatibility is critical
- Test extensively with real client applications if available
- Consider maintaining parallel Restlet implementation temporarily for comparison
- JAX-RS standards compliance makes future framework changes easier
- Quarkus hot reload significantly improves developer experience
- OpenAPI is more powerful and widely supported than WADL
- Consider API versioning (e.g., /api/v1/) for future-proofing
- Document all URL changes in a migration guide for API consumers
- REST Assured tests serve as both tests and documentation
- Performance should improve significantly with Quarkus vs Restlet
