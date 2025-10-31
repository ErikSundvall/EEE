# Build Instructions for LiU EEE

This document provides step-by-step instructions to build the LiU EEE project in a modern environment.

## Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Maven 3.6.0 or higher
- Git

## Current Status

As of 2025-10-31, the project **does not compile** due to missing dependencies. This guide will help you resolve these issues.

## Quick Summary of Issues

1. **Restlet framework** - Repository unavailable
2. **openEHR Java libraries** - Not in Maven Central
3. **BaseX** - Old versions not available
4. **XML Schemas** - Depend on openEHR schemas

## Step-by-Step Build Instructions

### Step 1: Build and Install openEHR Java Libraries

The openEHR libraries are the core dependency. They need to be built from source.

```bash
# Clone the openEHR java-libs repository
cd /tmp
git clone https://github.com/openEHR/java-libs.git
cd java-libs

# Checkout a stable version (optional, but recommended)
# git checkout <tag-or-branch>

# Build and install to local Maven repository (~/.m2/repository)
mvn clean install -DskipTests

# This will install all openEHR modules with groupId: org.openehr.java-libs
```

### Step 2: Update EEE pom.xml to Use Built openEHR Libraries

After building the openEHR libraries, you need to update the `pom.xml` in the EEE project.

Find the commented-out openEHR dependencies section (around line 210) and uncomment them, then change the groupId:

```xml
<!-- Change from: -->
<dependency>
    <groupId>openehr</groupId>
    <artifactId>openehr-rm-core</artifactId>
    <version>1.0.3-SNAPSHOT</version>
</dependency>

<!-- Change to: -->
<dependency>
    <groupId>org.openehr.java-libs</groupId>
    <artifactId>openehr-rm-core</artifactId>
    <version>0-SNAPSHOT</version>  <!-- Check what version was built -->
</dependency>
```

Repeat for all openEHR dependencies:
- openehr-rm-core
- openehr-rm-domain
- openehr-aom
- openehr-ap
- adl-parser
- rm-builder
- rm-skeleton

**Note:** You may need to check the exact version installed in your local Maven repository.

### Step 3: Resolve Restlet Dependencies

Option A: Try to find Restlet JARs from an archive repository or local cache.

Option B (Recommended): Migrate to a modern REST framework. This is a larger effort but more sustainable:
- Spring Boot + Spring Web
- JAX-RS (Jersey/RESTEasy)
- Quarkus

For a quick fix, you can try downloading Restlet 2.1.2 JARs from:
- Maven Central Archive (if available)
- Local Maven cache from another machine
- Restlet's archived releases

Then install them to your local repository:
```bash
mvn install:install-file -Dfile=org.restlet-2.1.2.jar \
    -DgroupId=org.restlet.jse -DartifactId=org.restlet \
    -Dversion=2.1.2 -Dpackaging=jar
```

Repeat for all Restlet dependencies.

### Step 4: Update BaseX Dependencies

Uncomment the BaseX dependencies in `pom.xml` and update to a modern version available in Maven Central:

```xml
<dependency>
    <groupId>org.basex</groupId>
    <artifactId>basex</artifactId>
    <version>10.7</version>  <!-- or latest stable -->
</dependency>
```

**Warning:** API changes may require code modifications.

### Step 5: Fix XML Schema Issues

The XML schemas reference openEHR types that may not be available. You have two options:

1. Temporarily disable XML schema compilation by commenting out the xmlbeans-maven-plugin in pom.xml
2. Obtain the openEHR XSD files and place them in the correct location

### Step 6: Attempt Compilation

```bash
cd /path/to/EEE
mvn clean compile
```

If you encounter errors:
1. Read the error messages carefully
2. Check dependency versions match what's in your local repository
3. Use `mvn dependency:tree` to diagnose dependency conflicts

### Step 7: Run Tests (if compilation succeeds)

```bash
mvn test
```

## Alternative: Docker-based Build (Future Enhancement)

Consider creating a Docker container with all dependencies pre-built to simplify the build process.

## Troubleshooting

### Problem: "Could not transfer artifact"
**Solution:** Check that the dependency exists in your local Maven repository (`~/.m2/repository`).

### Problem: "Type not found" in XSD compilation
**Solution:** Ensure openEHR libraries are properly installed and XML schemas are available.

### Problem: Compilation errors in Java code
**Solution:** API changes in updated dependencies may require code modifications. Update imports and method calls as needed.

### Problem: Test failures
**Solution:** Tests may depend on specific database configurations or resources. Check test configuration files.

## Recommended Long-term Modernization

For long-term maintainability, consider:

1. **Update to Java 17 or 21** (LTS versions)
2. **Migrate to Spring Boot** for REST services
3. **Update all dependencies** to current versions
4. **Add integration tests** with testcontainers
5. **Containerize** with Docker
6. **Add CI/CD pipeline** for automated builds

## Need Help?

If you encounter issues not covered here, please:
1. Check the MODERNIZATION.md file for detailed dependency information
2. Review Maven logs carefully (`mvn -X` for debug output)
3. Create an issue in the GitHub repository with:
   - Your Java version (`java -version`)
   - Your Maven version (`mvn -version`)
   - The full error message
   - Steps you've already tried

## References

- openEHR Java Libraries: https://github.com/openEHR/java-libs
- Maven Installation Guide: https://maven.apache.org/install.html
- Restlet Framework Documentation: https://restlet.talend.com/documentation/
