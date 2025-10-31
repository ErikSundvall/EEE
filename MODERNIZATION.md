# LiU EEE Modernization Report

**Date:** 2025-10-31  
**Status:** Partial Compilation Success with Significant Dependency Issues

## Executive Summary

This project was built around 2013 and has several critical issues preventing it from compiling in a modern environment (2025). The main problems are:

1. **Missing/Unavailable Dependencies** - Several key dependencies are no longer available in public Maven repositories
2. **Deprecated Repository URLs** - Maven repository URLs using HTTP instead of HTTPS
3. **Outdated Java Version** - Compiled for Java 1.7, which is very old

## Current Status

### What Works
- ✅ Repository URLs updated from HTTP to HTTPS
- ✅ Java compiler version updated from 1.7 to 1.8
- ✅ Modern Maven (3.9.11) and Java (17) available

### What Doesn't Work

#### 1. Restlet Framework Dependencies (CRITICAL)
The Restlet Maven repository URL (`maven.restlet.talend.com`) is no longer resolving. This affects:
- org.restlet.jse:org.restlet:2.1.2
- org.restlet.jse:org.restlet.ext.wadl:2.1.2
- org.restlet.jse:org.restlet.ext.xml:2.1.2
- org.restlet.jse:org.restlet.ext.json:2.1.2
- org.restlet.jse:org.restlet.ext.freemarker:2.1.2

**Impact:** The REST server framework is unavailable  
**Severity:** CRITICAL - Core functionality affected

#### 2. OpenEHR Java Libraries (CRITICAL)
The openEHR Java libraries (version 1.0.3-SNAPSHOT) are not available in any public Maven repository:
- openehr:openehr-rm-core:1.0.3-SNAPSHOT
- openehr:openehr-rm-domain:1.0.3-SNAPSHOT
- openehr:rm-builder:1.0.3-SNAPSHOT
- openehr:openehr-aom:1.0.3-SNAPSHOT
- openehr:adl-parser:1.0.3-SNAPSHOT
- openehr:openehr-ap:1.0.3-SNAPSHOT
- openehr:rm-skeleton:1.0.3-SNAPSHOT
- openehr:rm-validator:1.0.2-SNAPSHOT (exists in local repo)

**Note:** Only `rm-validator-1.0.2-SNAPSHOT.jar` is present in the local `repo/` directory.

**Impact:** Core openEHR functionality is unavailable  
**Severity:** CRITICAL - Core functionality affected

#### 3. BaseX XML Database Dependencies (HIGH)
BaseX dependencies are not available from configured repositories:
- org.basex:basex:7.6
- net.xqj:basex-xqj:1.2.0
- com.xqj2:xqj2:0.1.0
- javax.xml.xquery:xqj-api:1.0
- org.basex:basex-api:7.6

**Impact:** XML database functionality unavailable  
**Severity:** HIGH - Database operations affected

## Recommended Solutions

### Option 1: Build Missing Dependencies from Source (Recommended for Full Restoration)

#### OpenEHR Libraries
The openEHR Java libraries are available on GitHub at https://github.com/openEHR/java-libs

Steps:
```bash
# Clone the openEHR java-libs repository
git clone https://github.com/openEHR/java-libs.git
cd java-libs

# Build and install to local Maven repository
mvn clean install

# Then update EEE pom.xml to use the correct groupId
# Change from: <groupId>openehr</groupId>
# Change to: <groupId>org.openehr.java-libs</groupId>
```

#### Restlet Framework
Use Maven Central's archived Restlet releases:
```xml
<!-- Remove the maven-restlet repository section -->
<!-- Dependencies should be available from Maven Central -->
```

Or migrate to a modern REST framework like:
- Spring Boot + Spring Web
- JAX-RS (Jersey or RESTEasy)
- Quarkus

#### BaseX
Update to use newer BaseX versions available in Maven Central:
```xml
<dependency>
    <groupId>org.basex</groupId>
    <artifactId>basex</artifactId>
    <version>10.7</version> <!-- Latest stable version -->
</dependency>
```

### Option 2: Minimal Changes to Get Basic Compilation (Quick Start)

1. **Remove unavailable dependencies temporarily** - Comment out dependencies that cannot be resolved
2. **Fix remaining dependency URLs** - Ensure all repositories use HTTPS
3. **Update to compatible versions** - Where possible, update to versions available in Maven Central
4. **Document broken functionality** - Create a list of features that won't work

### Option 3: Complete Modernization (Long-term Solution)

This would involve:
1. Migrating to Spring Boot 3.x or Quarkus
2. Using modern openEHR SDK (org.ehrbase.openehr.sdk)
3. Updating all dependencies to current versions
4. Refactoring code to use modern Java features (Java 17+)
5. Adding comprehensive tests
6. Containerization with Docker

**Estimated Effort:** 2-4 weeks for experienced developer

## Dependency Analysis

### Available in Maven Central
- junit:junit:3.8.1 (outdated, recommend 4.13.2 or JUnit 5)
- org.json:json:20090211 (outdated, recommend 20240303)
- commons-configuration:commons-configuration:1.9 (recommend 1.10)
- commons-cli:commons-cli:1.2 (recommend 1.9.0)
- commons-collections:commons-collections:3.2.1 (recommend 3.2.2)
- commons-codec:commons-codec:1.8 (recommend 1.17.1)

### Not Available / Problematic
- All Restlet dependencies (repo down)
- All openEHR dependencies (not in Maven Central with this groupId)
- All BaseX dependencies at version 7.6 (very old)
- eXist-DB dependencies at version 2.0 (in local repo only)

## Test Status

The project has one basic test file:
- `src/test/java/se/liu/imt/mi/eee/AppTest.java` - A placeholder test that always passes

**Recommendation:** Cannot run tests until compilation succeeds.

## Changes Made

1. Updated `pom.xml`:
   - Changed HTTP repository URLs to HTTPS:
     - `http://uk.maven.org/maven2` → `https://repo.maven.apache.org/maven2`
     - `http://maven.restlet.org` → `https://maven.restlet.talend.com`
     - `http://xqj.net/maven` → `https://xqj.net/maven`
     - `http://files.basex.org/maven` → `https://files.basex.org/maven`
   - Updated Java compiler version from 1.7 to 1.8

## Next Steps

To proceed with modernization, the project owner should:

1. **Decide on scope**: Full modernization vs. minimal fixes
2. **Build openEHR dependencies**: Clone and build from https://github.com/openEHR/java-libs
3. **Replace Restlet**: Either find alternative Restlet repository or migrate to modern REST framework
4. **Update BaseX**: Use current versions from Maven Central
5. **Add missing JARs**: Populate the local `repo/` directory with built dependencies
6. **Test incrementally**: Build each module as dependencies become available

## References

- OpenEHR Java Libs: https://github.com/openEHR/java-libs
- Restlet Framework (archived): https://restlet.talend.com/
- BaseX XML Database: https://basex.org/
- Modern openEHR SDK: https://github.com/ehrbase/openEHR_SDK
