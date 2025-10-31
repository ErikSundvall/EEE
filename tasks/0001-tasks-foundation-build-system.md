# Task List: Phase 1 - Foundation & Build System

**Related PRD**: [0001-prd-liu-eee-modernization.md](0001-prd-liu-eee-modernization.md#phase-1-foundation--build-system-week-1)

**Goal**: Update the build system and core dependencies to enable compilation with modern Java and frameworks while removing unavailable dependencies.

**Estimated Effort**: Week 1 (40 hours)

## Relevant Files

- `pom.xml` - Maven project configuration; needs comprehensive updates for Java 17, Quarkus, and Archie dependencies
- `src/main/java/se/liu/imt/mi/eee/DemoStarter.java` - Main application entry point; will need updates for Quarkus compatibility
- `.gitignore` - May need updates to exclude Quarkus-specific build artifacts
- `README.md` - Should be updated with new build instructions once compilation succeeds
- `src/main/resources/application.properties` - New Quarkus configuration file (to be created)
- `src/main/resources/META-INF/resources/` - Directory for static resources in Quarkus (may need to be created)

### Notes

- Maven Central should be the primary dependency source; all dependencies must be available there
- The local `repo/` directory contains unavailable dependencies and should eventually be phased out
- Quarkus BOM (Bill of Materials) ensures consistent dependency versions across Quarkus extensions
- Java 17 LTS is the target version (with path to Java 21 in future)
- This phase focuses on getting the project to compile; runtime functionality will be addressed in later phases

## Tasks

- [ ] 1.0 Update Java Version and Build Configuration
  - [ ] 1.1 Update `pom.xml` to set Java version from 1.8 to 17 in maven-compiler-plugin configuration
  - [ ] 1.2 Update `project.build.sourceEncoding` to UTF-8 if not already set
  - [ ] 1.3 Update maven-compiler-plugin version from 3.1 to latest stable (3.11.0 or higher)
  - [ ] 1.4 Update other Maven plugins to current versions (xmlbeans-maven-plugin, javacc-maven-plugin)
  - [ ] 1.5 Add `maven.compiler.release` property set to 17 for consistent compilation
  - [ ] 1.6 Verify Maven version is 3.9+ by running `mvn --version`

- [ ] 2.0 Add Quarkus Framework Dependencies
  - [ ] 2.1 Add Quarkus platform BOM to `<dependencyManagement>` section with version 3.15.0 or later
  - [ ] 2.2 Add property `<quarkus.platform.version>3.15.0</quarkus.platform.version>`
  - [ ] 2.3 Add `io.quarkus.platform:quarkus-bom` dependency with type `pom` and scope `import`
  - [ ] 2.4 Add `io.quarkus:quarkus-maven-plugin` to build plugins section
  - [ ] 2.5 Add Quarkus extension: `quarkus-resteasy-reactive` for REST support
  - [ ] 2.6 Add Quarkus extension: `quarkus-resteasy-reactive-jackson` for JSON serialization
  - [ ] 2.7 Add Quarkus extension: `quarkus-resteasy-reactive-jaxb` for XML serialization
  - [ ] 2.8 Add Quarkus extension: `quarkus-qute` for templating (replacing Freemarker)
  - [ ] 2.9 Add Quarkus extension: `quarkus-security` for authentication and authorization
  - [ ] 2.10 Add Quarkus extension: `quarkus-arc` for CDI/dependency injection (usually included automatically)

- [ ] 3.0 Add Archie openEHR Library Dependencies
  - [ ] 3.1 Add property `<archie.version>3.15.0</archie.version>` or latest stable version
  - [ ] 3.2 Add dependency `com.nedap.healthcare.archie:archie-all` with version `${archie.version}`
  - [ ] 3.3 Verify Archie dependency is available in Maven Central
  - [ ] 3.4 Research if additional Archie modules are needed (openehr-rm-core, aom, etc.) or if archie-all suffices
  - [ ] 3.5 Check for transitive dependency conflicts with Quarkus dependencies

- [ ] 4.0 Remove Restlet Framework Dependencies
  - [ ] 4.1 Remove or comment out all Restlet dependencies (org.restlet.jse, org.restlet.ext.*)
  - [ ] 4.2 Remove Restlet Maven repository if it exists in `<repositories>` section
  - [ ] 4.3 Remove any Restlet-related properties from `<properties>` section
  - [ ] 4.4 Document removed Restlet dependencies in comments for historical reference
  - [ ] 4.5 Note that Restlet ServerResource classes will need migration (tracked in Phase 3)

- [ ] 5.0 Update XML Database Dependencies
  - [ ] 5.1 Update BaseX dependency from version 7.6 to 10.7 or latest stable
  - [ ] 5.2 Verify BaseX 10.7 is available in Maven Central
  - [ ] 5.3 Check BaseX changelog for breaking API changes between 7.6 and 10.x
  - [ ] 5.4 Update eXist-DB dependency from version 2.0 to 6.2.0 or latest, if still needed
  - [ ] 5.5 Research if eXist-DB can be removed entirely and BaseX used exclusively
  - [ ] 5.6 Update XML-DB API dependency to current version if explicitly declared

- [ ] 6.0 Update Apache Commons and Other Utility Libraries
  - [ ] 6.1 Identify all Apache Commons libraries currently in use (commons-lang, commons-io, etc.)
  - [ ] 6.2 Update commons-lang to commons-lang3 (latest version 3.14.0 or higher)
  - [ ] 6.3 Update commons-io to latest stable version (2.15.0 or higher)
  - [ ] 6.4 Update commons-codec to latest stable version if used
  - [ ] 6.5 Update commons-collections to commons-collections4 if used
  - [ ] 6.6 Update any other Apache Commons libraries to their latest versions
  - [ ] 6.7 Verify all updated libraries are compatible with Java 17

- [ ] 7.0 Update Logging Framework
  - [ ] 7.1 Identify current logging framework (likely java.util.logging or log4j)
  - [ ] 7.2 Add SLF4J API dependency if not using Quarkus's built-in logging
  - [ ] 7.3 Configure Quarkus logging to use appropriate backend (JBoss Logging)
  - [ ] 7.4 Remove deprecated logging dependencies (log4j 1.x, commons-logging)
  - [ ] 7.5 Add logging bridge dependencies if needed for third-party libraries
  - [ ] 7.6 Update log configuration files to Quarkus format (application.properties)

- [ ] 8.0 Update Testing Dependencies
  - [ ] 8.1 Update JUnit from version 3.x/4.x to JUnit 5 (Jupiter) latest stable
  - [ ] 8.2 Add `quarkus-junit5` dependency for Quarkus testing support
  - [ ] 8.3 Add `rest-assured` dependency for REST endpoint testing
  - [ ] 8.4 Add `quarkus-junit5-mockito` if mocking is needed
  - [ ] 8.5 Update maven-surefire-plugin to version 3.2.0 or higher for JUnit 5 support
  - [ ] 8.6 Ensure test directory structure follows Maven conventions (src/test/java)

- [ ] 9.0 Clean Up Old and Unavailable Dependencies
  - [ ] 9.1 Remove all dependencies from local `repo/` directory that are now in Maven Central
  - [ ] 9.2 Remove openEHR java-libs dependencies (to be replaced by Archie in Phase 2)
  - [ ] 9.3 Remove Freemarker dependency (to be replaced by Qute)
  - [ ] 9.4 Remove any snapshot dependencies or unstable versions
  - [ ] 9.5 Document removed dependencies and their replacements in a migration notes file
  - [ ] 9.6 Clean up commented-out dependency sections in pom.xml

- [ ] 10.0 Create Initial Quarkus Configuration
  - [ ] 10.1 Create `src/main/resources/application.properties` file
  - [ ] 10.2 Configure basic Quarkus properties (application name, port, context path)
  - [ ] 10.3 Configure Quarkus to match existing REST endpoint paths (e.g., quarkus.http.root-path)
  - [ ] 10.4 Set up development mode configuration (quarkus.dev settings)
  - [ ] 10.5 Configure static resource serving (quarkus.http.static-resources)
  - [ ] 10.6 Add database connection configuration placeholders for BaseX
  - [ ] 10.7 Configure logging levels for development (quarkus.log.level)

- [ ] 11.0 Initial Compilation Attempt and Dependency Resolution
  - [ ] 11.1 Run `mvn clean compile` and capture all compilation errors
  - [ ] 11.2 Identify missing dependencies from error messages
  - [ ] 11.3 Identify API incompatibilities that need code changes (defer to Phase 2 if openEHR-related)
  - [ ] 11.4 Add any missing transitive dependencies explicitly if needed
  - [ ] 11.5 Resolve dependency version conflicts using `mvn dependency:tree`
  - [ ] 11.6 Exclude conflicting transitive dependencies where necessary
  - [ ] 11.7 Document compilation errors that require code changes for later phases

- [ ] 12.0 Handle JavaCC Parser Dependencies
  - [ ] 12.1 Verify javacc-maven-plugin works with Java 17
  - [ ] 12.2 Update JavaCC generated code compatibility if needed
  - [ ] 12.3 Ensure AQL parser generation completes successfully
  - [ ] 12.4 Test that generated parser classes compile with Java 17
  - [ ] 12.5 Update any parser-related configurations in pom.xml

- [ ] 13.0 Handle XMLBeans Schema Compilation
  - [ ] 13.1 Verify xmlbeans-maven-plugin works with Java 17
  - [ ] 13.2 Update XMLBeans plugin version if compatibility issues exist
  - [ ] 13.3 Ensure schema compilation from `src/main/xsd` succeeds
  - [ ] 13.4 Verify generated XMLBeans classes compile with Java 17
  - [ ] 13.5 Check if XMLBeans is still needed or can be replaced with JAXB

- [ ] 14.0 Verify Project Compiles Successfully
  - [ ] 14.1 Run `mvn clean install` and ensure zero compilation errors
  - [ ] 14.2 Verify all Java source files compile without errors
  - [ ] 14.3 Verify all generated code (JavaCC, XMLBeans) compiles successfully
  - [ ] 14.4 Check that JAR/WAR artifact is created in target/ directory
  - [ ] 14.5 Verify no dependency download failures occur
  - [ ] 14.6 Document any warnings that should be addressed in future phases
  - [ ] 14.7 Create a baseline build log for comparison in later phases

- [ ] 15.0 Update Build Documentation
  - [ ] 15.1 Update BUILD_INSTRUCTIONS.md with new Java 17 requirement
  - [ ] 15.2 Document required Maven version (3.9+)
  - [ ] 15.3 Add Quarkus-specific build commands (`mvn quarkus:dev`, `mvn quarkus:build`)
  - [ ] 15.4 Document dependency sources (all from Maven Central)
  - [ ] 15.5 List any known compilation warnings and their status
  - [ ] 15.6 Document the build output and artifact locations

## Acceptance Criteria

- [ ] Project compiles successfully with `mvn clean install` using Java 17
- [ ] All dependencies are available from Maven Central (no local repo dependencies)
- [ ] Quarkus BOM and Archie library are properly integrated
- [ ] No Restlet dependencies remain in pom.xml
- [ ] BaseX is updated to version 10.x
- [ ] All Maven plugins are using current stable versions
- [ ] Build documentation is updated with new requirements
- [ ] Zero compilation errors (warnings are acceptable and documented)
- [ ] Build completes in under 2 minutes

## Dependencies

**Blocks**:
- Phase 2: openEHR Library Migration (cannot start until dependencies are available)
- Phase 3: REST Framework Migration (cannot start until dependencies are available)

**Prerequisites**:
- None (this is the foundation phase)

## Notes

- This phase focuses solely on getting the project to compile; runtime functionality is not expected
- Some Restlet-related code will have compilation errors until Phase 3; this is expected
- openEHR java-libs code will have compilation errors until Phase 2; this is expected
- The goal is to have all dependencies available and configured, even if some code needs migration
- Consider creating a git branch for this phase to isolate build system changes
- Test builds on multiple platforms (Linux, macOS, Windows) if possible
- Document any platform-specific build issues encountered
