# LiU EEE

## ⚠️ Modernization Status (November 2025)

**Phase 1 (Foundation & Build System) - IN PROGRESS**

The project is undergoing modernization from Java 8 + Restlet to Java 17 + Quarkus. Phase 1 build system updates are complete:

✅ **Completed:**
- Java 17 build configuration
- Quarkus 3.15.0 framework integration
- Archie 3.15.0 openEHR library integration
- BaseX 10.7 database library upgrade
- Updated Maven plugins and dependencies
- All dependencies now from Maven Central

⚠️ **Known Compilation Errors (Expected):**
The project currently does not compile - this is expected at the end of Phase 1. Compilation errors exist due to:
- Restlet framework code (to be migrated in Phase 3)
- Old openEHR library references (to be migrated in Phase 2)
- XMLBeans schema compilation (temporarily disabled)

**Next Steps:**
- Phase 2: Migrate openEHR library references to Archie
- Phase 3: Migrate Restlet REST endpoints to Quarkus JAX-RS

**Documentation:**
- 📄 **[STATUS.md](STATUS.md)** - Quick overview of compilation issues
- 📋 **[BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)** - Step-by-step build guide
- 📊 **[MODERNIZATION.md](MODERNIZATION.md)** - Detailed analysis and recommendations
- 🎯 **[PRD: Complete Modernization Plan](tasks/0001-prd-liu-eee-modernization.md)** - Product Requirements Document for migrating to Quarkus and Archie
- 📝 **[Phase 1 Task List](tasks/0001-tasks-foundation-build-system.md)** - Foundation & Build System tasks

---

A REST based Educational Electroinc Health Record (EHR) Environment based on openEHR.
This repository hosts the LiU EEE source code for the Linköping University Educational EHR Environment. (The openEHR website is at http://www.openehr.org)

### Links
- Wiki/news page (including release info): https://github.com/LiU-IMT/EEE/wiki
- Installation instructions: https://github.com/LiU-IMT/EEE/wiki/install
- Issue tracker: https://github.com/LiU-IMT/EEE/issues
- LiU EEE is Open Source Licensed using: Apache 2, see http://www.apache.org/licenses/LICENSE-2.0.html

A BMC paper that __explains the design__ is available online:
- Title: Applying representational state transfer (REST) architecture to archetype-based
electronic health record systems
- Authors: Erik Sundvall, Mikael Nyström, Daniel Karlsson, Martin Eneling, Rong Chen and Håkan Örman
- BMC Medical Informatics and Decision Making.2013, 13:57.
- URL: __http://www.biomedcentral.com/1472-6947/13/57__
- DOI: 10.1186/1472-6947-13-57
- PMID: 23656624

A presentation of an upcoming __Expression Repository__ that enables advanced __querying of SNOMED CT post-coordinated EHR content__:
- Title: An integrated Expression Repository EHR system
- Authors: Daniel Karlsson, Mikael Nyström, Bengt Kron
- URL: __http://www.ihtsdo.org/fileadmin/user_upload/doc/showcase/?t=show12_EhrDesign__

### Acknowledgements

This work was partly funded by the [Swedish National Board of Health and Welfare](http://www.socialstyrelsen.se/), 
by the [Swedish Association of Local Authorities and Regions (SALAR)](http://www.cehis.se/en), by [Cambio Healthcare Systems](http://www.cambio.se/), 
by TEKIT funds from [Linköping University](http://www.liu.se),  by the EU-funded regional network [NovaMedTech](http://novamedtech.se/), 
and by the [Vinnova](http://www.vinnova.se/sv/) funded project "Testbädd LiÖ".


The Department of Clinical Engineering (MTÖ) in the County Council of Östergötland supported 
feedback and funding for GUI prototyping through the [AIV project](http://www.advancedinfovis.org/).

======================

LiU EEE Coordinator:
Erik Sundvall, https://liu.se/en/employee/erisu87
Linköping University & Region Östergötland, Sweden
