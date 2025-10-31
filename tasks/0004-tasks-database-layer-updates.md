# Task List: Phase 4 - Database Layer Updates

**Related PRD**: [0001-prd-liu-eee-modernization.md](0001-prd-liu-eee-modernization.md#phase-4-database-layer-updates-week-3)

**Goal**: Update XML database integration to work with modern BaseX and potentially remove eXist-DB dependency, ensuring all database operations work correctly with the modernized stack.

**Estimated Effort**: Week 3 (40 hours)

## Relevant Files

- `src/main/java/se/liu/imt/mi/eee/db/xmldb/XMLDBHelper.java` - Abstract database helper interface
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/exist/ExistXMLDBHelper.java` - eXist-DB specific implementation
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/EHRXMLDBHandler.java` - Main EHR database handler
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/CombinedXQueryXpathService.java` - XQuery/XPath service
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/ContributionBuilderStorageInXMLDB.java` - Contribution storage
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/QueryStorageInXMLDB.java` - Query storage
- `src/main/java/se/liu/imt/mi/eee/db/xmldb/BookmarkStorageInXMLDB.java` - Bookmark storage
- `src/main/java/se/liu/imt/mi/eee/db/SharedXQueries.java` - Common XQuery definitions
- `src/main/java/se/liu/imt/mi/eee/AQL_Parser/` - AQL parser directory (JavaCC generated)
- `src/main/java/se/liu/imt/mi/eee/db/QueryContainer.java` - Query container for AQL to XQuery translation
- `src/defunct/java/se/liu/imt/mi/eee/db/xmldb/basex/BasexXMLDBHelper.java` - Previous BaseX implementation (may be reusable)
- Configuration files for database connection (restserver.properties, application.properties)
- Database initialization scripts if they exist

### Notes

- BaseX 7.6 → 10.7 is a major version jump; expect API changes
- XML-DB API standard may have changed or may still be compatible
- XQuery language version support may have changed (3.0 → 3.1)
- eXist-DB 2.0 → 6.2.0 is also a major jump; evaluate if still needed
- Consider using only BaseX to simplify architecture
- Transaction support must be preserved for data integrity
- Performance may improve significantly with BaseX 10.x
- Database schema/structure should remain compatible with existing data

## Tasks

- [ ] 1.0 Research BaseX 10.x API Changes
  - [ ] 1.1 Review BaseX 10.7 documentation and changelog from version 7.6
  - [ ] 1.2 Identify breaking API changes in database connection
  - [ ] 1.3 Identify XQuery syntax or function changes
  - [ ] 1.4 Document new features in BaseX 10.x that could be beneficial
  - [ ] 1.5 Check XML-DB API compatibility with BaseX 10.x
  - [ ] 1.6 Review transaction support changes
  - [ ] 1.7 Document connection pool configuration options
  - [ ] 1.8 Review performance improvements in BaseX 10.x

- [ ] 2.0 Evaluate eXist-DB Requirement
  - [ ] 2.1 Analyze why eXist-DB is used alongside BaseX
  - [ ] 2.2 Identify features unique to eXist-DB in current implementation
  - [ ] 2.3 Determine if BaseX 10.x can replace all eXist-DB functionality
  - [ ] 2.4 Evaluate migration complexity if removing eXist-DB
  - [ ] 2.5 Make decision: keep eXist-DB, migrate to BaseX only, or support both
  - [ ] 2.6 Document decision and rationale
  - [ ] 2.7 If keeping eXist-DB: plan update from 2.0 to 6.2.0

- [ ] 3.0 Update Database Connection Management
  - [ ] 3.1 Update XMLDBHelper interface if API changes are needed
  - [ ] 3.2 Create new BaseX 10.x implementation or update defunct one
  - [ ] 3.3 Update database connection configuration in application.properties
  - [ ] 3.4 Implement connection pooling for BaseX
  - [ ] 3.5 Configure connection timeouts and retry logic
  - [ ] 3.6 Implement proper resource cleanup (try-with-resources)
  - [ ] 3.7 Test database connection establishment
  - [ ] 3.8 Test connection pool behavior under load
  - [ ] 3.9 Add health check for database connectivity

- [ ] 4.0 Update BaseX-Specific Implementation
  - [ ] 4.1 Review defunct/java/se/liu/imt/mi/eee/db/xmldb/basex/BasexXMLDBHelper.java
  - [ ] 4.2 Create new `src/main/java/.../db/xmldb/basex/BaseXMLDBHelper.java`
  - [ ] 4.3 Update database initialization code for BaseX 10.x API
  - [ ] 4.4 Update collection creation/deletion methods
  - [ ] 4.5 Update resource storage and retrieval methods
  - [ ] 4.6 Update XQuery execution methods
  - [ ] 4.7 Update transaction handling (begin, commit, rollback)
  - [ ] 4.8 Test all CRUD operations with BaseX 10.x
  - [ ] 4.9 Verify backward compatibility with existing data

- [ ] 5.0 Update eXist-DB Implementation (if keeping)
  - [ ] 5.1 Update ExistXMLDBHelper.java for eXist-DB 6.2.0
  - [ ] 5.2 Update database connection code
  - [ ] 5.3 Update collection management
  - [ ] 5.4 Update resource operations
  - [ ] 5.5 Update XQuery execution
  - [ ] 5.6 Update transaction handling
  - [ ] 5.7 Test all operations with eXist-DB 6.2.0

- [ ] 6.0 Update XQuery Code for Compatibility
  - [ ] 6.1 Review all XQuery code in SharedXQueries.java
  - [ ] 6.2 Update XQuery syntax to XQuery 3.1 if needed
  - [ ] 6.3 Test function library compatibility (fn:, functx:, etc.)
  - [ ] 6.4 Update namespace declarations if changed
  - [ ] 6.5 Update any database-specific extension functions
  - [ ] 6.6 Test XQuery execution with sample data
  - [ ] 6.7 Verify query results match expected output
  - [ ] 6.8 Optimize XQuery for performance if needed

- [ ] 7.0 Update EHR Database Handler
  - [ ] 7.1 Update EHRXMLDBHandler.java for new database API
  - [ ] 7.2 Update EHR creation operations
  - [ ] 7.3 Update composition storage operations
  - [ ] 7.4 Update composition retrieval operations
  - [ ] 7.5 Update versioned object management
  - [ ] 7.6 Test EHR CRUD operations end-to-end
  - [ ] 7.7 Verify data integrity after operations
  - [ ] 7.8 Test concurrent access scenarios

- [ ] 8.0 Update Contribution Storage
  - [ ] 8.1 Update ContributionBuilderStorageInXMLDB.java
  - [ ] 8.2 Update contribution creation and storage
  - [ ] 8.3 Update contribution retrieval by ID
  - [ ] 8.4 Update contribution listing operations
  - [ ] 8.5 Update audit trail storage
  - [ ] 8.6 Test contribution workflow end-to-end
  - [ ] 8.7 Verify contribution metadata is correctly stored
  - [ ] 8.8 Test contribution rollback scenarios

- [ ] 9.0 Update Query Storage
  - [ ] 9.1 Update QueryStorageInXMLDB.java for new database API
  - [ ] 9.2 Update stored query creation
  - [ ] 9.3 Update stored query retrieval
  - [ ] 9.4 Update query result storage
  - [ ] 9.5 Test query storage and retrieval
  - [ ] 9.6 Verify query results are correctly persisted

- [ ] 10.0 Update Bookmark Storage
  - [ ] 10.1 Update BookmarkStorageInXMLDB.java
  - [ ] 10.2 Update bookmark creation
  - [ ] 10.3 Update bookmark retrieval
  - [ ] 10.4 Update bookmark deletion
  - [ ] 10.5 Update bookmark listing for users
  - [ ] 10.6 Test bookmark CRUD operations
  - [ ] 10.7 Verify user isolation for bookmarks

- [ ] 11.0 Test AQL to XQuery Translation
  - [ ] 11.1 Review AQL parser in AQL_Parser/ directory
  - [ ] 11.2 Verify AQL parser compilation with JavaCC
  - [ ] 11.3 Test AQL parsing with sample queries
  - [ ] 11.4 Update QueryContainer.java if needed
  - [ ] 11.5 Test AQL to XQuery translation for simple queries
  - [ ] 11.6 Test translation for complex queries (joins, aggregations)
  - [ ] 11.7 Verify generated XQuery executes correctly on BaseX 10.x
  - [ ] 11.8 Test query result formatting and serialization
  - [ ] 11.9 Compare query results with baseline (if available)

- [ ] 12.0 Update XQuery and XPath Service
  - [ ] 12.1 Update CombinedXQueryXpathService.java
  - [ ] 12.2 Update XQuery compilation and execution
  - [ ] 12.3 Update XPath evaluation
  - [ ] 12.4 Update result set handling
  - [ ] 12.5 Test XQuery service with various queries
  - [ ] 12.6 Test XPath service with various paths
  - [ ] 12.7 Verify error handling for invalid queries

- [ ] 13.0 Implement Transaction Support
  - [ ] 13.1 Verify transaction API in BaseX 10.x
  - [ ] 13.2 Implement transaction boundaries for multi-step operations
  - [ ] 13.3 Implement rollback on error
  - [ ] 13.4 Test transaction commit scenarios
  - [ ] 13.5 Test transaction rollback scenarios
  - [ ] 13.6 Test concurrent transactions
  - [ ] 13.7 Verify data consistency after failed transactions
  - [ ] 13.8 Add logging for transaction events

- [ ] 14.0 Test Database Versioning and History
  - [ ] 14.1 Test versioned object creation
  - [ ] 14.2 Test version retrieval (latest, specific version)
  - [ ] 14.3 Test version history listing
  - [ ] 14.4 Verify version IDs are correctly generated (ObjectVersionID)
  - [ ] 14.5 Test version comparison
  - [ ] 14.6 Verify audit trail is maintained correctly
  - [ ] 14.7 Test version deletion if supported

- [ ] 15.0 Test Database Indexing and Performance
  - [ ] 15.1 Review indexing configuration in BaseX 10.x
  - [ ] 15.2 Create indexes for frequently queried paths
  - [ ] 15.3 Create indexes for EHR IDs, composition IDs
  - [ ] 15.4 Test query performance with and without indexes
  - [ ] 15.5 Benchmark common query patterns
  - [ ] 15.6 Optimize slow queries
  - [ ] 15.7 Configure full-text indexing if needed
  - [ ] 15.8 Document indexing strategy

- [ ] 16.0 Migrate Existing Data (if applicable)
  - [ ] 16.1 Assess if existing database data needs migration
  - [ ] 16.2 Export data from BaseX 7.6 or eXist-DB 2.0
  - [ ] 16.3 Create data migration script
  - [ ] 16.4 Test migration on sample data
  - [ ] 16.5 Verify data integrity after migration
  - [ ] 16.6 Create rollback plan for migration
  - [ ] 16.7 Document migration procedure

- [ ] 17.0 Update Database Configuration
  - [ ] 17.1 Update application.properties with database settings
  - [ ] 17.2 Configure database URL, port, credentials
  - [ ] 17.3 Configure connection pool size
  - [ ] 17.4 Configure transaction timeout
  - [ ] 17.5 Configure query timeout
  - [ ] 17.6 Configure separate settings for dev, test, prod profiles
  - [ ] 17.7 Externalize sensitive configuration (passwords)
  - [ ] 17.8 Document all configuration options

- [ ] 18.0 Implement Database Initialization
  - [ ] 18.1 Create database initialization service
  - [ ] 18.2 Initialize database collections on first startup
  - [ ] 18.3 Create default indexes
  - [ ] 18.4 Load sample data if in dev mode
  - [ ] 18.5 Test initialization on fresh database
  - [ ] 18.6 Test idempotency (running initialization multiple times)
  - [ ] 18.7 Add health check for database schema

- [ ] 19.0 Error Handling and Resilience
  - [ ] 19.1 Implement proper exception handling for database errors
  - [ ] 19.2 Create custom exceptions for database operations
  - [ ] 19.3 Implement retry logic for transient errors
  - [ ] 19.4 Implement circuit breaker for repeated failures (if needed)
  - [ ] 19.5 Log database errors with sufficient context
  - [ ] 19.6 Return user-friendly error messages
  - [ ] 19.7 Test error scenarios (connection loss, timeout, etc.)

- [ ] 20.0 Integration Testing
  - [ ] 20.1 Create integration tests for database layer
  - [ ] 20.2 Use Testcontainers for BaseX if applicable
  - [ ] 20.3 Test EHR creation and retrieval
  - [ ] 20.4 Test composition storage and queries
  - [ ] 20.5 Test contribution workflow
  - [ ] 20.6 Test query execution (AQL and XQuery)
  - [ ] 20.7 Test bookmark operations
  - [ ] 20.8 Test concurrent operations
  - [ ] 20.9 Test large data volumes (stress testing)
  - [ ] 20.10 Verify all integration tests pass

- [ ] 21.0 Performance Testing and Optimization
  - [ ] 21.1 Benchmark composition storage time
  - [ ] 21.2 Benchmark composition retrieval time
  - [ ] 21.3 Benchmark query execution time (simple and complex)
  - [ ] 21.4 Compare performance with BaseX 7.6 baseline
  - [ ] 21.5 Identify performance bottlenecks
  - [ ] 21.6 Optimize database queries
  - [ ] 21.7 Tune database configuration for performance
  - [ ] 21.8 Document performance characteristics and benchmarks

- [ ] 22.0 Database Administration Tools
  - [ ] 22.1 Document how to access BaseX admin interface
  - [ ] 22.2 Document database backup procedure
  - [ ] 22.3 Document database restore procedure
  - [ ] 22.4 Create backup/restore scripts if needed
  - [ ] 22.5 Document database maintenance tasks
  - [ ] 22.6 Document monitoring and diagnostics
  - [ ] 22.7 Create troubleshooting guide

- [ ] 23.0 Update Database Documentation
  - [ ] 23.1 Document database schema/structure
  - [ ] 23.2 Document collection organization
  - [ ] 23.3 Document XQuery functions and their purposes
  - [ ] 23.4 Document indexing strategy
  - [ ] 23.5 Document transaction patterns
  - [ ] 23.6 Update developer guide with database setup
  - [ ] 23.7 Create database API documentation

- [ ] 24.0 Final Verification
  - [ ] 24.1 Run complete application with new database layer
  - [ ] 24.2 Test end-to-end workflows (EHR creation to query)
  - [ ] 24.3 Verify no database-related errors in logs
  - [ ] 24.4 Test database recovery after failures
  - [ ] 24.5 Verify data integrity across all operations
  - [ ] 24.6 Run full regression test suite
  - [ ] 24.7 Document any known issues or limitations

## Acceptance Criteria

- [ ] BaseX updated to version 10.7 and working correctly
- [ ] eXist-DB decision made (removed or updated to 6.2.0)
- [ ] All database CRUD operations functional
- [ ] XQuery execution works with all existing queries
- [ ] AQL to XQuery translation works correctly
- [ ] Transaction support preserved and tested
- [ ] Versioned object management working
- [ ] No data loss or corruption
- [ ] Performance meets or exceeds baseline
- [ ] All integration tests passing
- [ ] Database configuration documented
- [ ] Backup/restore procedures documented

## Dependencies

**Blocks**:
- Phase 5: Testing & Validation (needs working database layer)

**Prerequisites**:
- Phase 1: Foundation & Build System (BaseX dependency must be updated)
- Phase 2: openEHR Library Migration (database stores RM objects with new serialization)
- Phase 3: REST Framework Migration (REST endpoints use database layer)

## Notes

- Database layer is critical - any bugs here cause data integrity issues
- Test thoroughly with real data scenarios
- Consider keeping BaseX 7.6 running in parallel during migration for comparison
- XQuery 3.1 is mostly backward compatible with 3.0, but test thoroughly
- BaseX 10.x performance improvements should be significant
- Transaction support is essential for contribution builder workflow
- Consider using BaseX GUI for debugging and verification during development
- eXist-DB removal simplifies architecture but verify no functionality is lost
- Database migration should be reversible in case of issues
- Document any breaking changes in database API for future maintainers
- Consider adding database metrics/monitoring for production use
