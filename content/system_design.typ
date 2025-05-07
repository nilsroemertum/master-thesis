#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Architecture
#TODO[
  This chapter follows the System Design Document Template in @bruegge2004object. You describe in this chapter how you map the concepts of the application domain to the solution domain. Some sections are optional, if they do not apply to your problem. Cite @bruegge2004object several times in this chapter.
]
#GOAL[
  - Explicitly state here this chapter is general-purpose and independent of specific cases.
  - Mention that this design is generic for medical imaging and later will be tested for the specific use case of synlab described in section 4 requirements
]

== Overview
#TODO[
  Provide a brief overview of the software architecture and references to other chapters (e.g. requirements), references to existing systems, constraints impacting the software architecture..
]
#GOAL[
  - Brief summary of the developed architecture mentioning requirements in chapter 4 (FR, NFR)
  - Highlight key constraints impacting the architecture (e.g., vendor-neutrality, interoperability, security regulations).
  - Brief mention of references to existing solutions reviewed in Related Work (Chapter 3) and how the architecture differs/improves.
]

== Design Goals
#TODO[
  Derive design goals from your nonfunctional requirements, prioritize them (as they might conflict with each other) and describe the rationale of your prioritization. Any trade-offs between design goals (e.g., build vs. buy, memory space vs. response time), and the rationale behind the specific solution should be described in this section
]
#GOAL[
  - Design goals (generalized for any medical imaging scenario)
    - DG1 High Performance (Highest Priority)
      - Fast transfer speeds for large medical files (x mins for 20–30 GB).
    - DG2 Vendor-Neutral Interoperability (Highest Priority)
      - Compatibility with existing clinical systems (PACS/LIS) using e.g. DICOM/DICOMweb.
    - DG3 Scalability
      - Stable performance during high concurrent usage
    - DG4 Usability
      - User-friendly interfaces, minimal training required
    - (if implemented) DGX Security & Compliance
      - Full GDPR/HIPAA compliance; secure encrypted transmission/storage
  - Design Goal Prioritization Rationale
    - High performance and interoperability are critical for clinical relevance; hence prioritized highest.
    - Scalability, security, and usability follow closely due to direct impact on clinical acceptance and operational practicality.
  - Trade-offs
    - Performance vs. Security: Encryption overhead vs. transfer speed optimized through efficient encryption standards.
    - Scalability vs. Complexity: Chose modular components despite slight complexity increase for future-proofing.
    - Build vs. Buy: Decided on cloud solutions vs. custom hardware/software due to flexibility and vendor-neutrality.
]

== Subsystem Decomposition
#TODO[
  Describe the architecture of your system by decomposing it into subsystems and the services provided by each subsystem. Use UML class diagrams including packages / components for each subsystem.
]
#GOAL[
  - General subsystems independent of Synlab usecase
    - Image Upload & Transfer Subsystem
      - File upload, resumable transfers, progress tracking.
    - Storage Subsystem
      - Secure cloud object storage, encryption/decryption, metadata indexing.
    - Interoperability Layer
      - DICOM/DICOMweb gateway and integration with PACS/LIS.
    - If implemented
      - User Management Subsystem
        - Role-based access control, user authentication, audit logging.
      - Notification Subsystem
        - Event-based notifications to stakeholders (emails, system alerts).
  - Rationale for decomposition
    - Clearly defined functional separation simplifies maintainability and scalability.
    - Separation facilitates reuse and independent testing.
]

== Hardware Software Mapping
#TODO[
  This section describes how the subsystems are mapped onto existing hardware and software components. The description is accompanied by a UML deployment diagram. The existing components are often off-the-shelf components. If the components are distributed on different nodes, the network infrastructure and the protocols are also described.
]
#GOAL[
  Usage of UML Deployment Diagram (generic cloud-based approach)
  - Cloud Infrastructure
    - Object storage (e.g., AWS S3, Azure Blob)
    - Secure web application servers, scalable compute resources.
  - Clinical Infrastructure
    - PACS and LIS servers (existing systems)
  - Client Devices
    - Standardized browsers/web apps for clinicians and imaging technicians
  - Network & Protocols:
    - HTTPS/TLS for secure web access.
    - DICOMweb REST API integration.
    - (if needed) VPN or secure tunneling to existing clinical systems.
]

== Persistent Data Management
#TODO[
  Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
]
#GOAL[
  - Data Persistence Strategy (first draft)
    - Cloud-based object storage for large imaging files.
    - Relational database (e.g., PostgreSQL) for metadata, user accounts, logs.
  - Persistent Entities
    - Medical images
    - Patient metadata (if used by system)
    - (if implemented) User Accounts & Permissions, Audit Logs & Access History
  - Rationale
    - Object storage chosen for efficient, scalable large file storage of large scans
    - Relational database selected for structured data management, querying, auditing
]

== Access Control
#TODO[
  Optional section describing the access control and security issues based on the nonfunctional requirements. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of en- cryption algorithms.
]
#GOAL[
  - Only include if I decide to include Permissions and Roles into scope of thesis
]

== Global Software Control
#TODO[
  Optional section describing the control flow of the system, in particular, whether a monolithic, event-driven control flow or concurrent processes have been selected, how requests are initiated and specific synchronization issues
]
#GOAL[
  - Event-driven architecture: triggered uploads, notifications, retrieval requests
  - Concurrent processing: multiple uploads/downloads managed concurrently
  - (Asynchronous handling: background file processing to improve performance.)
  - Asynchronous and event-driven approach improves responsiveness and user experience.
]

== Boundry Conditions
#TODO[
  Optional section describing the use cases how to start up the separate components of the system, how to shut them down, and what to do if a component or the system fails.
]
#GOAL[
  - Maybe include how to start/stop/recover cloud systems without data loss (I would rather leave it out but let's see if it gets more important)
    - System Startup: Clear step-by-step startup sequence for cloud services, database, integrations.
    - System Shutdown: Graceful shutdown ensuring no data loss.
    - Failure Recovery: Strategies for resumable uploads, automatic recovery of interrupted processes.
  - Ensuring robust operational procedures improves reliability and reduces downtime
]