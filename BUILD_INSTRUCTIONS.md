# Build Instructions for LiU EEE

This document provides step-by-step instructions to build the LiU EEE project after Phase 1 modernization.

## Prerequisites

- **Java Development Kit (JDK) 17** (LTS version)
- **Apache Maven 3.9.0 or higher**
- Git

## Current Status (Phase 1 Complete)

As of 2025-11-01, Phase 1 (Foundation & Build System) is complete. The project has been updated to:
- Java 17
- Quarkus 3.15.0
- Archie 3.15.0 (modern openEHR library)
- BaseX 10.7
- All dependencies from Maven Central

**The project currently does not compile** - this is expected at the end of Phase 1 due to:
1. Restlet framework code (to be migrated in Phase 3)
2. Old openEHR library references (to be migrated in Phase 2)
3. XMLBeans temporarily disabled

## Quick Start

### Step 1: Verify Prerequisites

```bash
# Check Java version (must be 17)
java -version
# Should show: openjdk version "17.x.x"

# Check Maven version (must be 3.9+)
mvn --version
# Should show: Apache Maven 3.9.x or higher
```

### Step 2: Download Dependencies

```bash
cd /path/to/EEE
mvn clean dependency:resolve
```

This will download all dependencies from Maven Central. Expected time: 2-5 minutes on first run.

### Step 3: Attempt Compilation (Will Fail - This is Expected)

```bash
mvn clean compile
```

**Expected Result:** Compilation will fail with errors related to:
- `org.restlet.*` package not found (Restlet framework - to be replaced in Phase 3)
- `org.openehr.rm.*` package not found (old openEHR - to be replaced in Phase 2)
- `org.apache.xmlbeans.*` package not found (XMLBeans temporarily disabled)
- `freemarker.template.*` package not found (Freemarker - to be replaced in Phase 3)

These errors are **expected and documented**. Do not attempt to fix them manually.

## Quarkus Development Mode (Not Yet Functional)

Once Phases 2 and 3 are complete, you will be able to run:

```bash
# Start Quarkus in development mode with hot reload
mvn quarkus:dev
```

This command is not functional yet but will be after migration is complete.

## Dependency Information

All dependencies are now sourced from **Maven Central** only:

| Dependency | Version | Purpose |
|------------|---------|---------|
| Quarkus Platform | 3.15.0 | Modern REST framework (replaces Restlet) |
| Archie | 3.15.0 | Modern openEHR library (replaces java-libs) |
| BaseX | 10.7 | XML database |
| Commons Collections4 | 4.4 | Utilities |
| Commons Codec | 1.16.0 | Encoding utilities |

## Next Steps for Full Compilation

To complete the modernization and achieve successful compilation:

1. **Phase 2**: Migrate openEHR library references from old `org.openehr.*` to Archie
2. **Phase 3**: Migrate REST endpoints from Restlet to Quarkus JAX-RS
3. **Phase 4**: Update database layer for BaseX 10.7 compatibility

See [tasks/0001-prd-liu-eee-modernization.md](tasks/0001-prd-liu-eee-modernization.md) for the complete modernization plan.

## Build Artifacts

After Phase 1, Maven downloads dependencies successfully. Build artifacts will be created in:
- `target/` - Compiled classes and build outputs
- Build time: ~30 seconds (after initial dependency download)

## Troubleshooting

### Problem: Java version mismatch
**Solution:** Ensure you're using Java 17. Use `java -version` to check.

### Problem: Maven version too old
**Solution:** Upgrade to Maven 3.9.0 or higher.

### Problem: Dependency download failures
**Solution:** Check your internet connection. All dependencies are now in Maven Central.

### Problem: Compilation errors about Restlet/openEHR classes
**Solution:** This is expected at the end of Phase 1. These will be resolved in Phases 2 and 3.

## For Contributors

If you're working on the modernization:
1. Read the [complete PRD](tasks/0001-prd-liu-eee-modernization.md)
2. Follow the [Phase 1 Task List](tasks/0001-tasks-foundation-build-system.md)
3. Coordinate work to avoid conflicts

## References

- Quarkus Documentation: https://quarkus.io/guides/
- Archie (openEHR Library): https://github.com/openEHR/archie
- BaseX Documentation: https://basex.org/
- Maven Documentation: https://maven.apache.org/
