# Product Requirements Document: LiU EEE Complete Modernization

## Introduction/Overview

The Linköping University Educational EHR Environment (LiU EEE) is a REST-based educational Electronic Health Record system built on openEHR standards in 2013. The project currently does not compile due to unavailable dependencies and uses deprecated technologies (Restlet framework for REST APIs, outdated openEHR Java libraries, and Java 1.8). This PRD outlines the complete modernization of the LiU EEE platform to use contemporary technologies while maintaining its educational purpose and openEHR compliance.

**Problem Statement**: The LiU EEE codebase cannot be compiled or run in modern environments (2025) due to:
1. Unavailable Restlet framework dependencies (repository down)
2. Outdated openEHR Java libraries (java-libs) not available in Maven Central
3. Deprecated XML database dependencies (BaseX 7.6, eXist-DB 2.0)
4. Old Java version (1.8) and outdated dependencies

**Goal**: Modernize the LiU EEE platform to use:
- **Quarkus** as the REST framework (replacing Restlet)
- **Archie** as the openEHR library (replacing openEHR java-libs)
- Modern Java (17 or 21 LTS)
- Contemporary build tooling and best practices

## Goals

1. **Restore Compilability**: Enable the project to compile and run in modern Java environments
2. **Migrate REST Framework**: Replace Restlet with Quarkus while preserving all REST API endpoints
3. **Modernize openEHR Integration**: Replace openEHR java-libs with Archie library, using only the features actually required
4. **Update Dependencies**: Migrate to current versions of all third-party libraries
5. **Maintain Educational Value**: Preserve the educational purpose and ease of use for students
6. **Improve Maintainability**: Add modern development practices (CI/CD, containerization, testing)
7. **Preserve Functionality**: Maintain all existing features and REST API compatibility where possible

## Detailed Analysis

### Current openEHR Library Usage Analysis

Based on code analysis, the LiU EEE system uses the following openEHR components:

**Archetype Model (org.openehr.am)** - 84 usages:
- Archetype parsing and validation
- Archetype constraint model (CObject, CAttribute, CPrimitive types)
- Template flattening (Flattener, OETParser)
- Archetype ontology and terminology

**Reference Model (org.openehr.rm)** - 101 usages:
- Composition structure
- Data types (DvText, DvCodedText, DvQuantity, DvDateTime, etc.)
- Common structures (Locatable, Contribution, AuditDetails)
- Support structures (ObjectVersionID, ArchetypeID, UUID)
- Terminology service

**XML Binding (org.openehr.binding)** - 13 usages:
- XMLBinding for serialization/deserialization
- Schema-based XML processing

**Additional Components**:
- Validation framework (DataValidator)
- RM object builders (SkeletonGenerator, RMBuilder)
- Measurement services

### Archie Compatibility Assessment

**Archie (com.nedap.healthcare.archie) provides**:
- ✅ ADL 2.0 parser (upgrade from ADL 1.4)
- ✅ Complete Archetype Object Model (AOM)
- ✅ Reference Model implementation (openEHR RM)
- ✅ Template flattening and operational templates
- ✅ JSON and XML serialization/deserialization
- ✅ Archetype validation
- ✅ APath query support
- ✅ Active maintenance and modern Java support

**Migration Compatibility**:
- **HIGH COMPATIBILITY**: Most LiU EEE features can be migrated to Archie
- **IMPROVED FEATURES**: Archie provides better ADL 2.0 support
- **PACKAGE CHANGES**: Import statements need updating from `org.openehr.*` to Archie equivalents
- **API DIFFERENCES**: Some API method signatures differ, requiring code adaptation
- **BENEFIT**: Archie is actively maintained, available in Maven Central, and supports modern Java

### Current Restlet Framework Usage Analysis

**Restlet Components Used** (50+ imports):
- Core: Application, Component, Server, Restlet, Router
- Resources: ServerResource, WadlServerResource (9 custom resource classes)
- Representations: JsonRepresentation, XmlRepresentation, FileRepresentation
- Security: ChallengeAuthenticator, MapVerifier
- Routing: Template-based routing (5 router classes)
- Extensions: Freemarker templates, WADL generation
- Static file serving: Directory resource

**Key REST API Patterns**:
1. **EHR Resources**: CRUD operations on compositions, contributions, versioned objects
2. **Contribution Builder**: Multi-step contribution creation
3. **Query Interface**: AQL to XQuery translation and execution
4. **Bookmarks**: User bookmark management
5. **Static Content**: Web UI and documentation serving

### Quarkus Migration Assessment

**Quarkus Benefits**:
- ✅ Modern JAX-RS implementation (RESTEasy Reactive)
- ✅ Native REST endpoint support with annotations (@GET, @POST, etc.)
- ✅ Built-in JSON/XML serialization (Jackson/JAXB)
- ✅ Dependency injection (CDI)
- ✅ Native compilation support (GraalVM)
- ✅ Excellent developer experience (hot reload, dev UI)
- ✅ MicroProfile standards compliance
- ✅ Security built-in (OIDC, JWT, etc.)

**Migration Strategy**:
1. Convert Restlet Application → Quarkus Application
2. Convert ServerResource classes → JAX-RS Resource classes
3. Replace Restlet routing → JAX-RS @Path annotations
4. Convert representations → Jackson/JAXB beans
5. Replace Freemarker → Qute templates (Quarkus templating)
6. Migrate authentication → Quarkus Security

## User Stories

### US-1: Developer Setup
**As a** new developer joining the project,  
**I want to** clone the repository and run `mvn clean install` successfully,  
**So that** I can start contributing without dependency hunting.

**Acceptance Criteria**:
- All dependencies available in Maven Central
- Build completes without errors
- Tests run successfully
- Documentation is up-to-date

### US-2: Student Learning
**As a** medical informatics student,  
**I want to** run the EEE server locally and experiment with openEHR concepts,  
**So that** I can learn about EHR systems and openEHR in a practical environment.

**Acceptance Criteria**:
- Single command to start the server (e.g., `mvn quarkus:dev`)
- Clear documentation for setup
- Example data and tutorials available
- REST API accessible at familiar endpoints

### US-3: REST API Compatibility
**As an** educator with existing teaching materials,  
**I want** the REST API endpoints to remain compatible,  
**So that** my existing examples and exercises still work.

**Acceptance Criteria**:
- All existing endpoint paths preserved
- Request/response formats unchanged
- Authentication mechanisms compatible
- WADL/OpenAPI documentation available

### US-4: Modern Development
**As a** maintainer of the project,  
**I want** modern development tooling and practices,  
**So that** the project remains sustainable and easy to update.

**Acceptance Criteria**:
- CI/CD pipeline for automated testing
- Docker containerization
- Modern Java version (17+)
- Automated dependency updates
- Security scanning

### US-5: openEHR Compliance
**As a** researcher using openEHR,  
**I want** the system to use current openEHR standards and libraries,  
**So that** I can integrate with other openEHR tools and systems.

**Acceptance Criteria**:
- Uses Archie library (current openEHR implementation)
- Supports ADL 2.0
- Compatible with modern openEHR archetypes
- Can export/import standard openEHR formats

## Functional Requirements

### Phase 1: Foundation & Build System (Week 1)

**FR-1.1**: Update Java version from 1.8 to Java 17 LTS  
**FR-1.2**: Update Maven configuration to use modern plugin versions  
**FR-1.3**: Add Quarkus BOM (Bill of Materials) to pom.xml  
**FR-1.4**: Add Archie dependency (com.nedap.healthcare.archie:archie-all:3.15.0 or later)  
**FR-1.5**: Remove all Restlet dependencies  
**FR-1.6**: Update BaseX to current version (10.x) or migrate to alternative  
**FR-1.7**: Update all Apache Commons libraries to current versions  
**FR-1.8**: Add Quarkus extensions: quarkus-resteasy-reactive, quarkus-resteasy-reactive-jackson, quarkus-qute  
**FR-1.9**: Ensure project compiles with updated dependencies  

### Phase 2: openEHR Library Migration (Week 1-2)

**FR-2.1**: Create mapping document from org.openehr.* packages to Archie equivalents  
**FR-2.2**: Update all Archetype Model imports to use Archie ADL parser  
**FR-2.3**: Update Reference Model imports to use Archie RM implementation  
**FR-2.4**: Replace XMLBinding with Archie's JSON/XML serialization  
**FR-2.5**: Update template flattening to use Archie's Flattener  
**FR-2.6**: Migrate archetype validation to Archie's validation framework  
**FR-2.7**: Update SkeletonGenerator usage to Archie equivalents  
**FR-2.8**: Test archetype parsing with existing ADL files  
**FR-2.9**: Verify composition creation and validation  
**FR-2.10**: Update ArchetypeAndTemplateRepository class to use Archie's repository mechanism  

### Phase 3: REST Framework Migration (Week 2-3)

**FR-3.1**: Create Quarkus Application class replacing Restlet Component  
**FR-3.2**: Convert DemoStarter to use Quarkus lifecycle management  
**FR-3.3**: Convert all ServerResource classes to JAX-RS @Path annotated classes  
**FR-3.4**: Implement equivalent functionality for the following resources:
  - EHR resources (ContributionResource, VersionedObjectResource, etc.)
  - Contribution Builder resources
  - Bookmark resources
  - Query resources
  - Utility resources (HashUtilResource, TraceResource)  
**FR-3.5**: Replace Restlet Router classes with JAX-RS @Path hierarchies  
**FR-3.6**: Convert Freemarker templates to Qute templates  
**FR-3.7**: Implement static file serving using Quarkus mechanisms  
**FR-3.8**: Replace Restlet authentication with Quarkus Security  
**FR-3.9**: Preserve all HTTP methods (GET, POST, PUT, DELETE)  
**FR-3.10**: Maintain query parameter handling  
**FR-3.11**: Preserve response status codes and headers  
**FR-3.12**: Generate OpenAPI documentation (replacing WADL)  

### Phase 4: Database Layer Updates (Week 3)

**FR-4.1**: Update XMLDBHelper implementations for current BaseX or alternative  
**FR-4.2**: Update eXist-DB integration if still required  
**FR-4.3**: Test all database CRUD operations  
**FR-4.4**: Verify XQuery execution  
**FR-4.5**: Update AQL to XQuery translation layer  
**FR-4.6**: Test contribution storage and retrieval  
**FR-4.7**: Verify versioned object management  

### Phase 5: Testing & Validation (Week 3-4)

**FR-5.1**: Create integration tests for all REST endpoints  
**FR-5.2**: Create unit tests for openEHR operations  
**FR-5.3**: Test archetype loading and validation  
**FR-5.4**: Test template flattening  
**FR-5.5**: Test composition creation and storage  
**FR-5.6**: Test query execution (AQL)  
**FR-5.7**: Performance testing compared to original  
**FR-5.8**: Load testing for concurrent users  

### Phase 6: Documentation & Deployment (Week 4)

**FR-6.1**: Update README.md with new setup instructions  
**FR-6.2**: Create Docker containerization  
**FR-6.3**: Create docker-compose setup with database  
**FR-6.4**: Update API documentation (OpenAPI/Swagger)  
**FR-6.5**: Create migration guide from old to new system  
**FR-6.6**: Update developer documentation  
**FR-6.7**: Create deployment guide  
**FR-6.8**: Add CI/CD pipeline configuration (GitHub Actions)  

### Phase 7: Enhancement & Polish (Week 4+)

**FR-7.1**: Add health checks and monitoring endpoints  
**FR-7.2**: Add metrics collection  
**FR-7.3**: Implement proper logging with structured logging  
**FR-7.4**: Add configuration profiles (dev, test, prod)  
**FR-7.5**: Consider native compilation with GraalVM  
**FR-7.6**: Add security scanning to CI/CD  
**FR-7.7**: Implement rate limiting if needed  
**FR-7.8**: Add caching layer for frequently accessed archetypes  

## Non-Goals (Out of Scope)

1. **UI Redesign**: The existing web UI will be preserved with minimal changes. Modern frontend framework migration is out of scope.
2. **Feature Additions**: No new features beyond what exists in the current system.
3. **Database Migration**: Will not migrate away from XML databases if they still work adequately.
4. **AQL Parser Rewrite**: The existing AQL parser will be preserved if possible.
5. **Backwards Compatibility with Old APIs**: While we aim to preserve endpoint compatibility, we won't support deprecated Restlet-specific features.
6. **Multi-tenancy**: Not adding multi-tenant capabilities.
7. **Cloud-specific Features**: Not optimizing specifically for any cloud provider.
8. **Mobile Apps**: No mobile application development.
9. **FHIR Integration**: Not adding FHIR support (remains openEHR-only).
10. **Production-scale Performance**: Focus is on educational use, not production EHR performance.

## Design Considerations

### Architecture Principles
- **Clean Separation**: Clear separation between REST layer, business logic, and data layer
- **Dependency Injection**: Use CDI throughout for loose coupling
- **Configuration Externalization**: All configuration in application.properties
- **Stateless Design**: REST endpoints remain stateless

### REST API Design
- **Endpoint Preservation**: Maintain existing URL patterns where possible
  - `/ehr/{ehrId}/...` for EHR operations
  - `/contribution/...` for contributions
  - `/query/...` for queries
  - `/bookmark/...` for bookmarks
- **Content Negotiation**: Support both JSON and XML where currently supported
- **Error Handling**: Standardized error responses with appropriate HTTP status codes

### openEHR Integration Patterns
- **Archetype Repository**: Centralized archetype and template management
- **Validation Pipeline**: Validate compositions against archetypes before storage
- **Serialization**: Use Archie's built-in JSON/XML serialization
- **Path Navigation**: Use Archie's APath support for querying compositions

### Development Environment
- **Quarkus Dev Mode**: Enable hot reload for rapid development
- **Dev Services**: Use Quarkus dev services for database during development
- **Testing**: Use REST Assured for REST endpoint testing
- **Mocking**: Use WireMock for external service mocking if needed

## Technical Considerations

### Technology Stack
- **Java**: 17 LTS (with path to Java 21)
- **Framework**: Quarkus 3.x
- **openEHR**: Archie 3.15.0+
- **Build Tool**: Maven 3.9+
- **XML Database**: BaseX 10.x (or evaluate modern alternatives)
- **JSON Processing**: Jackson (via Quarkus)
- **XML Processing**: JAXB (via Quarkus)
- **Testing**: JUnit 5, REST Assured, Testcontainers
- **Templating**: Qute (Quarkus native)

### Key Dependencies
```xml
<properties>
    <quarkus.version>3.15.0</quarkus.version>
    <archie.version>3.15.0</archie.version>
    <java.version>17</java.version>
</properties>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>io.quarkus.platform</groupId>
            <artifactId>quarkus-bom</artifactId>
            <version>${quarkus.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <!-- Quarkus -->
    <dependency>
        <groupId>io.quarkus</groupId>
        <artifactId>quarkus-resteasy-reactive-jackson</artifactId>
    </dependency>
    <dependency>
        <groupId>io.quarkus</groupId>
        <artifactId>quarkus-resteasy-reactive-jaxb</artifactId>
    </dependency>
    <dependency>
        <groupId>io.quarkus</groupId>
        <artifactId>quarkus-qute</artifactId>
    </dependency>
    <dependency>
        <groupId>io.quarkus</groupId>
        <artifactId>quarkus-security</artifactId>
    </dependency>
    
    <!-- Archie openEHR -->
    <dependency>
        <groupId>com.nedap.healthcare.archie</groupId>
        <artifactId>archie-all</artifactId>
        <version>${archie.version}</version>
    </dependency>
    
    <!-- Database -->
    <dependency>
        <groupId>org.basex</groupId>
        <artifactId>basex</artifactId>
        <version>10.7</version>
    </dependency>
</dependencies>
```

### Migration Mapping

#### Restlet to Quarkus
| Restlet | Quarkus Equivalent |
|---------|-------------------|
| `ServerResource` | JAX-RS `@Path` class |
| `@Get` | `@GET` |
| `@Post` | `@POST` |
| `@Put` | `@PUT` |
| `@Delete` | `@DELETE` |
| `Representation` | Response entity (POJO) |
| `Router` | JAX-RS `@Path` hierarchy |
| `Application` | Quarkus Application class |
| `ChallengeAuthenticator` | `@RolesAllowed` / Quarkus Security |
| `TemplateRepresentation` | Qute Template |
| `Directory` | Static resources in `src/main/resources/META-INF/resources` |

#### openEHR java-libs to Archie
| java-libs | Archie Equivalent |
|-----------|------------------|
| `org.openehr.am.archetype.Archetype` | `com.nedap.archie.aom.Archetype` |
| `org.openehr.am.template.Flattener` | `com.nedap.archie.flattener.Flattener` |
| `org.openehr.rm.composition.Composition` | `com.nedap.archie.rm.composition.Composition` |
| `org.openehr.binding.XMLBinding` | Archie JSON/XML serializers |
| `org.openehr.build.SkeletonGenerator` | Archie's `RMObjectBuilder` |
| `org.openehr.validation.DataValidator` | Archie's `RMObjectValidator` |

### Database Considerations
- **BaseX Update**: Migrate from 7.6 to 10.7 (may require XQuery syntax updates)
- **eXist-DB**: Evaluate if still needed or if BaseX can handle all requirements
- **Transaction Support**: Ensure transaction capabilities are preserved
- **XQuery Version**: Update queries to XQuery 3.1 if needed

### Security Considerations
- **Authentication**: Implement using Quarkus Security (currently uses basic HTTP auth)
- **Authorization**: Role-based access control for sensitive operations
- **HTTPS**: Configure TLS for production deployments
- **Input Validation**: Validate all REST inputs
- **XSS Prevention**: Sanitize all user inputs displayed in UI
- **SQL/XQuery Injection**: Use parameterized queries

### Performance Considerations
- **Startup Time**: Quarkus provides much faster startup than traditional Java apps
- **Memory Usage**: Profile and optimize for educational server environments
- **Archetype Caching**: Cache parsed archetypes and templates in memory
- **Database Connection Pooling**: Configure appropriate pool sizes
- **Native Compilation**: Consider GraalVM native image for deployment

## Success Metrics

### Technical Metrics
1. **Build Success Rate**: 100% successful builds on CI/CD
2. **Compilation Time**: < 2 minutes for clean build
3. **Startup Time**: < 5 seconds in dev mode, < 2 seconds in production mode
4. **Test Coverage**: > 70% code coverage for core functionality
5. **Dependency Vulnerabilities**: Zero high/critical vulnerabilities
6. **API Compatibility**: 100% of existing endpoints functional

### Performance Metrics
1. **Response Time**: < 200ms for simple GET requests
2. **Composition Creation**: < 500ms for standard composition
3. **Query Execution**: < 1s for typical AQL query
4. **Concurrent Users**: Support 50+ concurrent users (educational scenario)

### Developer Experience Metrics
1. **Setup Time**: New developer can build and run in < 15 minutes
2. **Hot Reload**: Code changes reflected in < 3 seconds
3. **Documentation**: Complete API documentation via OpenAPI/Swagger
4. **Error Messages**: Clear, actionable error messages for common issues

### Educational Metrics
1. **Student Adoption**: Can be used in IMT courses without technical issues
2. **Learning Curve**: Students can create first composition within 30 minutes of tutorial
3. **Resource Usage**: Can run on student laptops (< 2GB RAM)

## Open Questions

1. **Database Strategy**: Should we continue with both BaseX and eXist-DB, or standardize on one?
   - **Recommendation**: Evaluate BaseX 10.x capabilities; migrate away from eXist-DB if possible

2. **ADL Version Support**: Should we support both ADL 1.4 and ADL 2.0?
   - **Recommendation**: Primary support for ADL 2.0, provide conversion utilities for ADL 1.4

3. **Authentication Method**: Should we modernize authentication to OAuth2/OIDC?
   - **Recommendation**: Keep basic auth for educational simplicity, document how to add OIDC

4. **Static Web UI**: Should we keep the existing static HTML/JS or modernize?
   - **Recommendation**: Keep existing for MVP, modernization as future enhancement

5. **API Versioning**: Should we implement API versioning for future changes?
   - **Recommendation**: Add `/api/v1/` prefix to all endpoints for future versioning

6. **Template Format**: Support both OET (Operational Templates) and ADL 2 templates?
   - **Recommendation**: Use Archie's operational template support, convert existing OETs

7. **Logging Strategy**: Continue with java.util.logging or switch to SLF4J/Logback?
   - **Recommendation**: Use Quarkus's built-in logging (JBoss Logging with SLF4J facade)

8. **Configuration Management**: How to handle multiple deployment environments?
   - **Recommendation**: Use Quarkus profiles (dev, test, prod)

9. **Testing Data**: Should we include comprehensive test datasets?
   - **Recommendation**: Include minimal test data in repo, provide script to load extended datasets

10. **Contribution Model**: How to enable community contributions?
    - **Recommendation**: Add CONTRIBUTING.md, issue templates, PR templates

## Implementation Phases Summary

### Phase 1: Foundation (Week 1)
- Update build system and core dependencies
- Add Quarkus and Archie
- Achieve successful compilation

### Phase 2: openEHR Migration (Weeks 1-2)
- Migrate all openEHR library usage to Archie
- Update archetype and template handling
- Test composition creation and validation

### Phase 3: REST Migration (Weeks 2-3)
- Convert all REST endpoints to Quarkus
- Migrate templates and static content
- Implement authentication

### Phase 4: Integration & Testing (Week 3-4)
- Database layer updates and testing
- Comprehensive integration testing
- Performance validation

### Phase 5: Deployment & Documentation (Week 4)
- Docker containerization
- CI/CD setup
- Documentation updates
- Migration guide

**Total Estimated Effort**: 4 weeks (160 hours) for experienced Java/Quarkus developer

## Risks and Mitigation

### Technical Risks
1. **Risk**: API incompatibilities between Archie and java-libs
   - **Mitigation**: Create abstraction layer for critical differences
   
2. **Risk**: BaseX API changes break existing XQuery code
   - **Mitigation**: Comprehensive testing of all database operations
   
3. **Risk**: Performance regression with new stack
   - **Mitigation**: Performance testing at each phase

### Project Risks
1. **Risk**: Scope creep beyond modernization
   - **Mitigation**: Strict adherence to functional requirements, defer enhancements
   
2. **Risk**: Educational disruption if changes break existing materials
   - **Mitigation**: Maintain API compatibility, provide migration guide
   
3. **Risk**: Lack of test coverage makes regression testing difficult
   - **Mitigation**: Create tests for critical paths during migration

## Appendices

### A. Current System Inventory
- **113 Java source files**
- **9 Restlet ServerResource classes**
- **5 Router classes**
- **84 Archetype Model usages**
- **101 Reference Model usages**
- **13 XML Binding usages**

### B. Reference Documentation
- **Archie Documentation**: https://github.com/openEHR/archie
- **Quarkus Documentation**: https://quarkus.io/guides/
- **openEHR Specifications**: https://specifications.openehr.org/
- **LiU EEE Paper**: http://www.biomedcentral.com/1472-6947/13/57

### C. Contact and Resources
- **Original Author**: Erik Sundvall, Linköping University
- **Repository**: https://github.com/ErikSundvall/EEE
- **Issue Tracker**: https://github.com/ErikSundvall/EEE/issues

---

**Document Version**: 1.0  
**Created**: 2025-10-31  
**Target Audience**: Senior Java Developer, openEHR Specialist  
**Approval Required**: Project Maintainer, Educational Program Coordinator
