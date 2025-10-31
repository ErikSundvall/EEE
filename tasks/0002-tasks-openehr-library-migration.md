# Task List: Phase 2 - openEHR Library Migration

**Related PRD**: [0001-prd-liu-eee-modernization.md](0001-prd-liu-eee-modernization.md#phase-2-openehr-library-migration-week-1-2)

**Goal**: Migrate from deprecated openEHR java-libs to the modern Archie library, updating all archetype model, reference model, and serialization code.

**Estimated Effort**: Week 1-2 (40-80 hours)

## Relevant Files

- `src/main/java/se/liu/imt/mi/eee/structure/ArchetypeAndTemplateRepository.java` - Central archetype/template repository; major refactoring needed
- `src/main/java/se/liu/imt/mi/eee/structure/` - Package containing openEHR structure handling
- `src/main/java/se/liu/imt/mi/eee/validation/` - Validation framework using openEHR java-libs
- `src/main/java/se/liu/imt/mi/eee/db/` - Database layer with RM object serialization
- All files with imports from `org.openehr.am.*` - Archetype Model imports (84 usages)
- All files with imports from `org.openehr.rm.*` - Reference Model imports (101 usages)
- All files with imports from `org.openehr.binding.*` - XML Binding imports (13 usages)
- Documentation files explaining openEHR usage patterns
- `/docs/openehr-migration-mapping.md` - New mapping document (to be created)

### Notes

- Archie uses different package structure: `com.nedap.archie.*` instead of `org.openehr.*`
- Archie supports ADL 2.0 while java-libs supported ADL 1.4; this is generally backward compatible
- Archie's API is more modern but conceptually similar to java-libs
- JSON serialization is built into Archie; no need for custom XMLBinding solutions
- Template flattening API has changed but functionality is equivalent
- This phase will have many compilation errors until all imports are updated

## Tasks

- [ ] 1.0 Create openEHR Migration Mapping Document
  - [ ] 1.1 Create `/docs/openehr-migration-mapping.md` file
  - [ ] 1.2 Document package mapping: `org.openehr.am.*` → `com.nedap.archie.aom.*`
  - [ ] 1.3 Document package mapping: `org.openehr.rm.*` → `com.nedap.archie.rm.*`
  - [ ] 1.4 Document class mapping for commonly used classes (Archetype, Composition, CObject, etc.)
  - [ ] 1.5 Document method signature changes for key APIs
  - [ ] 1.6 Document serialization approach changes (XMLBinding → Archie JSON/XML)
  - [ ] 1.7 Document builder pattern changes (SkeletonGenerator → RMObjectBuilder)
  - [ ] 1.8 Document validation framework changes (DataValidator → RMObjectValidator)
  - [ ] 1.9 Include code examples for common migration patterns
  - [ ] 1.10 List API differences that require logic changes (not just import updates)

- [ ] 2.0 Analyze Current openEHR Usage Patterns
  - [ ] 2.1 Run `grep -r "import org.openehr" src/main/java` to identify all usage
  - [ ] 2.2 Categorize imports by package (am, rm, binding, build, validation)
  - [ ] 2.3 Identify which classes from java-libs are most heavily used
  - [ ] 2.4 Document data types in use (DvText, DvCodedText, DvQuantity, DvDateTime, etc.)
  - [ ] 2.5 Document constraint types in use (CObject, CAttribute, CPrimitive, etc.)
  - [ ] 2.6 Identify template flattening usage patterns (Flattener, OETParser)
  - [ ] 2.7 Identify archetype ontology and terminology usage
  - [ ] 2.8 Document any custom extensions or wrappers around openEHR classes

- [ ] 3.0 Update Archetype Model (AOM) Imports
  - [ ] 3.1 Replace `import org.openehr.am.archetype.Archetype` with Archie equivalent
  - [ ] 3.2 Replace `import org.openehr.am.archetype.ontology.*` imports with Archie equivalents
  - [ ] 3.3 Replace `import org.openehr.am.archetype.constraintmodel.*` imports (CObject, CAttribute, etc.)
  - [ ] 3.4 Update CPrimitive type imports (CPrimitiveObject, CString, CInteger, etc.)
  - [ ] 3.5 Update archetype assertion and query imports
  - [ ] 3.6 Update template and operational template imports
  - [ ] 3.7 Fix compilation errors from import changes
  - [ ] 3.8 Verify archetype parsing still works with test archetypes

- [ ] 4.0 Update Reference Model (RM) Imports
  - [ ] 4.1 Replace `import org.openehr.rm.composition.*` with Archie RM composition classes
  - [ ] 4.2 Replace `import org.openehr.rm.datastructure.*` with Archie equivalents
  - [ ] 4.3 Replace `import org.openehr.rm.datatypes.*` imports (DvText, DvCodedText, etc.)
  - [ ] 4.4 Update DvQuantity, DvDateTime, DvBoolean, and other data type imports
  - [ ] 4.5 Replace `import org.openehr.rm.common.*` (Locatable, Party, AuditDetails, etc.)
  - [ ] 4.6 Update support structure imports (ObjectVersionID, ArchetypeID, UUID, etc.)
  - [ ] 4.7 Replace `import org.openehr.rm.support.terminology.*` with Archie terminology service
  - [ ] 4.8 Fix compilation errors from RM class changes
  - [ ] 4.9 Verify Composition creation and manipulation still works

- [ ] 5.0 Migrate XML/JSON Serialization
  - [ ] 5.1 Identify all usage of `org.openehr.binding.XMLBinding`
  - [ ] 5.2 Create utility class `ArchieSerializationHelper.java` for JSON/XML operations
  - [ ] 5.3 Implement JSON serialization using Archie's `JacksonUtil` class
  - [ ] 5.4 Implement XML serialization using Archie's XML serializer
  - [ ] 5.5 Replace XMLBinding.marshal() calls with Archie JSON/XML serialization
  - [ ] 5.6 Replace XMLBinding.unmarshal() calls with Archie deserialization
  - [ ] 5.7 Update content negotiation in REST layer to use new serialization
  - [ ] 5.8 Test round-trip serialization (object → JSON → object)
  - [ ] 5.9 Test round-trip serialization (object → XML → object)
  - [ ] 5.10 Verify existing XML compositions can still be imported

- [ ] 6.0 Update Template Flattening
  - [ ] 6.1 Identify usage of `org.openehr.am.template.Flattener`
  - [ ] 6.2 Replace with Archie's `com.nedap.archie.flattener.Flattener`
  - [ ] 6.3 Update OETParser usage to Archie's operational template handling
  - [ ] 6.4 Update template parsing to use Archie's ADL parser
  - [ ] 6.5 Modify flattening API calls to match Archie's method signatures
  - [ ] 6.6 Test template flattening with existing OET files
  - [ ] 6.7 Verify operational templates are correctly generated
  - [ ] 6.8 Test flattened archetypes for constraint inheritance
  - [ ] 6.9 Update error handling for flattening errors

- [ ] 7.0 Migrate Archetype Validation
  - [ ] 7.1 Identify usage of `org.openehr.validation.DataValidator`
  - [ ] 7.2 Replace with Archie's `RMObjectValidator` class
  - [ ] 7.3 Update validation method calls to Archie API
  - [ ] 7.4 Configure Archie validator with appropriate validation rules
  - [ ] 7.5 Update validation error handling and reporting
  - [ ] 7.6 Test validation with valid compositions (should pass)
  - [ ] 7.7 Test validation with invalid compositions (should fail with clear errors)
  - [ ] 7.8 Verify constraint validation (min/max, required fields, etc.)
  - [ ] 7.9 Test terminology validation if applicable

- [ ] 8.0 Update RM Object Builders
  - [ ] 8.1 Identify usage of `org.openehr.build.SkeletonGenerator`
  - [ ] 8.2 Replace with Archie's `RMObjectBuilder` or equivalent
  - [ ] 8.3 Update skeleton generation logic to use Archie API
  - [ ] 8.4 Test skeleton generation for compositions
  - [ ] 8.5 Verify generated skeletons are valid and complete
  - [ ] 8.6 Update RMBuilder usage if present in codebase
  - [ ] 8.7 Test that built RM objects pass validation

- [ ] 9.0 Update Archetype Repository Class
  - [ ] 9.1 Open `ArchetypeAndTemplateRepository.java` for major refactoring
  - [ ] 9.2 Replace archetype storage mechanism to use Archie's repository concepts
  - [ ] 9.3 Update archetype loading from file system to use Archie's ADL parser
  - [ ] 9.4 Update template loading and caching mechanism
  - [ ] 9.5 Implement archetype indexing for fast lookup (by archetype ID)
  - [ ] 9.6 Update operational template caching
  - [ ] 9.7 Implement lazy loading for large archetype sets
  - [ ] 9.8 Add error handling for malformed archetypes
  - [ ] 9.9 Test repository initialization with existing archetype directory
  - [ ] 9.10 Verify all archetypes load successfully without errors

- [ ] 10.0 Update Path Query Support (APath)
  - [ ] 10.1 Identify usage of path-based queries on RM objects
  - [ ] 10.2 Migrate to Archie's APath support (if used)
  - [ ] 10.3 Update path navigation code to use Archie API
  - [ ] 10.4 Test path-based data extraction from compositions
  - [ ] 10.5 Verify path queries work with nested structures

- [ ] 11.0 Update Measurement and Terminology Services
  - [ ] 11.1 Identify usage of `org.openehr.rm.support.measurement.*`
  - [ ] 11.2 Migrate to Archie's measurement service if available
  - [ ] 11.3 Update terminology service usage for coded terms
  - [ ] 11.4 Verify terminology bindings work correctly
  - [ ] 11.5 Test DvCodedText creation with terminology constraints

- [ ] 12.0 Update Contribution and Versioning Support
  - [ ] 12.1 Identify RM classes used for contributions (Contribution, AuditDetails, etc.)
  - [ ] 12.2 Update to Archie's equivalent RM classes
  - [ ] 12.3 Verify contribution metadata is correctly created
  - [ ] 12.4 Test versioned object ID generation (ObjectVersionID)
  - [ ] 12.5 Verify audit trail information is preserved
  - [ ] 12.6 Test contribution commit workflow

- [ ] 13.0 Fix Compilation Errors Across Codebase
  - [ ] 13.1 Run `mvn clean compile` and capture all openEHR-related errors
  - [ ] 13.2 Fix errors in `/structure` package
  - [ ] 13.3 Fix errors in `/validation` package
  - [ ] 13.4 Fix errors in `/db` package (serialization-related)
  - [ ] 13.5 Fix errors in `/ehr` package (EHR resource classes)
  - [ ] 13.6 Fix errors in `/cb` package (contribution builder)
  - [ ] 13.7 Fix errors in any utility classes using openEHR
  - [ ] 13.8 Resolve method signature mismatches
  - [ ] 13.9 Resolve field access changes (getter/setter differences)
  - [ ] 13.10 Ensure no `org.openehr` imports remain except in deprecated/defunct code

- [ ] 14.0 Update Unit Tests for openEHR Code
  - [ ] 14.1 Identify all tests that use openEHR java-libs classes
  - [ ] 14.2 Update test imports to use Archie classes
  - [ ] 14.3 Update test data creation to use Archie API
  - [ ] 14.4 Fix test assertions for API changes
  - [ ] 14.5 Add new tests for Archie-specific functionality (ADL 2.0 support)
  - [ ] 14.6 Verify all archetype parsing tests pass
  - [ ] 14.7 Verify all validation tests pass
  - [ ] 14.8 Verify all serialization tests pass

- [ ] 15.0 Test Archetype Parsing with Real Data
  - [ ] 15.1 Locate existing ADL archetype files in repository or test data
  - [ ] 15.2 Test parsing of ADL 1.4 archetypes with Archie
  - [ ] 15.3 Test parsing of ADL 2.0 archetypes if available
  - [ ] 15.4 Verify archetype ontology sections are parsed correctly
  - [ ] 15.5 Verify constraint model (definition section) is parsed correctly
  - [ ] 15.6 Test error reporting for invalid archetypes
  - [ ] 15.7 Document any ADL 1.4 features that don't parse correctly

- [ ] 16.0 Test Template Operations
  - [ ] 16.1 Test loading operational templates (OET files)
  - [ ] 16.2 Test flattening templates to create operational templates
  - [ ] 16.3 Verify template constraints override archetype constraints correctly
  - [ ] 16.4 Test template terminology binding
  - [ ] 16.5 Verify flattened templates can be used for validation

- [ ] 17.0 Test Composition Creation and Validation
  - [ ] 17.1 Create test composition programmatically using Archie RM classes
  - [ ] 17.2 Populate composition with test data (DvText, DvCodedText, DvQuantity, etc.)
  - [ ] 17.3 Validate composition against archetype using Archie validator
  - [ ] 17.4 Serialize composition to JSON and verify output
  - [ ] 17.5 Serialize composition to XML and verify output
  - [ ] 17.6 Deserialize JSON back to composition object
  - [ ] 17.7 Deserialize XML back to composition object
  - [ ] 17.8 Verify round-trip integrity (original equals deserialized)
  - [ ] 17.9 Test composition with nested structures (clusters, elements)
  - [ ] 17.10 Test composition with all major data types

- [ ] 18.0 Performance Testing and Optimization
  - [ ] 18.1 Benchmark archetype loading time compared to java-libs baseline (if available)
  - [ ] 18.2 Benchmark composition validation time
  - [ ] 18.3 Benchmark serialization/deserialization performance
  - [ ] 18.4 Identify any performance regressions
  - [ ] 18.5 Optimize archetype caching strategy if needed
  - [ ] 18.6 Profile memory usage with large archetype sets
  - [ ] 18.7 Document performance characteristics

- [ ] 19.0 Update Developer Documentation
  - [ ] 19.1 Document the migration from java-libs to Archie
  - [ ] 19.2 Update code comments referencing openEHR java-libs
  - [ ] 19.3 Create examples of common Archie operations
  - [ ] 19.4 Document differences developers should be aware of
  - [ ] 19.5 Update JavaDoc for changed method signatures
  - [ ] 19.6 Document new Archie-specific capabilities (ADL 2.0, improved performance)

- [ ] 20.0 Final Verification
  - [ ] 20.1 Run `mvn clean install` - should compile without openEHR-related errors
  - [ ] 20.2 Run all unit tests - all openEHR tests should pass
  - [ ] 20.3 Verify no `org.openehr.*` imports in active code (defunct code excluded)
  - [ ] 20.4 Verify archetype repository initializes correctly
  - [ ] 20.5 Verify compositions can be created, validated, and serialized
  - [ ] 20.6 Create integration test demonstrating full openEHR workflow
  - [ ] 20.7 Document any remaining issues or limitations

## Acceptance Criteria

- [ ] All `org.openehr.*` imports replaced with Archie equivalents in active code
- [ ] Project compiles successfully with no openEHR java-libs dependencies
- [ ] Archetype parsing works for all existing archetype files
- [ ] Template flattening produces correct operational templates
- [ ] Composition creation and validation work correctly
- [ ] JSON and XML serialization round-trip successfully
- [ ] All unit tests related to openEHR functionality pass
- [ ] Performance is comparable to or better than java-libs baseline
- [ ] Migration mapping document is complete and accurate
- [ ] No regression in openEHR functionality

## Dependencies

**Blocks**:
- Phase 3: REST Framework Migration (some REST resources use openEHR classes)
- Phase 4: Database Layer Updates (database layer uses RM serialization)
- Phase 5: Testing & Validation (needs working openEHR integration)

**Prerequisites**:
- Phase 1: Foundation & Build System (must be complete - Archie dependency must be available)

## Notes

- This is the most complex technical migration in the project
- Expect to spend significant time understanding Archie API differences
- Keep java-libs code in defunct/ directory for reference during migration
- Consider creating utility wrapper classes to abstract Archie API if it helps
- Test frequently with real archetype and composition data
- Archie documentation: https://github.com/openEHR/archie
- Some API differences may require rethinking implementation approaches
- ADL 2.0 support is a bonus - ensure ADL 1.4 compatibility is maintained
- Consider creating an integration test suite specifically for openEHR operations
- Serialization format should remain compatible with existing stored compositions
