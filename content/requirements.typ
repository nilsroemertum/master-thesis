#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Requirements <Requirements>
#TODO[
  This chapter follows the Requirements Analysis Document Template in @bruegge:2010:ObjectorientedSoftwareEngineering. Important: Make sure that the whole chapter is independent of the chosen technology and development platform. The idea is that you illustrate concepts, taxonomies and relationships of the application domain independent of the solution domain! Cite @bruegge:2010:ObjectorientedSoftwareEngineering several times in this chapter.

]
#GOAL[
  - Clearly domain-focused, tailored to general medical imaging requirements, with references to Synlab as a specific motivation/example
  - Go into the Synlab use case and describe that this pathology image sharing process system is an exemplary use case the architecture we will develop in chapter 5 can be implemented and evaluated.
  - Functional and nonfunctional requirements outlined independently of technology
]

This chapter specifies the requirements for large-scale medical imaging systems, using Synlab’s remote pathology data-sharing workflow as a representative use case. The current system, its limitations, and the resulting requirements and system models are derived from this scenario. The structure and methodology follow Brügge and Dutoit’s framework for requirements engineering in their extensive book about object-oriented software engineering, which distinguishes between elicitation—producing a specification understandable to the client—and analysis—producing an analysis model interpretable without ambiguity by developers @bruegge:2010:ObjectorientedSoftwareEngineering.

Before detailing the requirements, a high-level overview of the activities leading to their definition is provided. This includes a recap of the work completed in previous chapters and the activities performed in the current chapter, along with the resulting artifacts. @RequirementsActivities summarizes this process. After defining the thesis motivation and scope in @Introduction, establishing the technical background in @Background, and reviewing relevant literature in @RelatedWork, this chapter analyses Synlab’s existing system and derives the requirements.

#figure(
image("../figures/uml/thesis/requirements-activities.png", width: 100%),
caption: [Activities and resulting artifacts in the requirements engineering process, adapted to the Synlab remote pathology use case. After analyzing the existing system, the requirements engineering process is split up into elicitation and analysis. Finally, all results get validated by stakeholders and if not accepted another iteration starts at the elicitation to address emerging issues (UML activity diagram).]
) <RequirementsActivities>

The first activity focused on analyzing Synlab’s existing system. This involves structured interviews with the IT department and operational staff to understand the current technical setup, integration points, and workflow dependencies. The collected information was consolidated into a system documentation (see @ExistingSystem), which provides a detailed overview of the system’s architecture. This documentation served as the primary input for the subsequent requirements elicitation phase.

The requirements elicitation activity produces functional requirements, quality attributes, constraints, scenarios, and use cases. In this step, close collaboration between stakeholders and developers is essential to bridge domain and technical knowledge gaps. A scenario-based approach is applied, as it allows capturing both operational context and user needs through direct observation of workflows and targeted interviews @bruegge:2010:ObjectorientedSoftwareEngineering. For Synlab, this included walkthroughs of image acquisition and remote sharing processes, as well as discussions with stakeholders about business objectives and clinical priorities.

Once elicitation outputs are documented (see @FunctionalRequirements to @UseCaseModel), stakeholders validate them through scenario reviews and prototype testing, enabling iterative refinement of the system description. Scenario reviews ensure that the documented workflows and requirements accurately reflected user needs and operational realities, while prototype testing allows stakeholders to experience and assess selected functionalities in a tangible form. This process not only verifies the correctness and completeness of the requirements but also fosters a shared understanding between technical and non-technical participants.

The validated requirements specification—covering functional requirements, quality attributes, constraints, scenarios, and use cases—formed the basis for the analysis phase. In this phase, developers formalize the specification, examined boundary conditions, and addressed exceptional cases @bruegge:2010:ObjectorientedSoftwareEngineering. The outcome is an analysis model that included the analysis object model and the dynamic model. In parallel, user interface mockups are refined to incorporate updated insights and ensure alignment with the evolving system understanding (see @AnalysisObjectModel to @UserInterface).

Following the analysis, all artifacts from elicitation and analysis are presented to stakeholders for final validation. If approval is not granted, the process returns to the elicitation phase to adjust or refine the specification before undergoing another analysis cycle. Once validated, the work proceeds to architectural design in @Architecture, ensuring that the system blueprint was built on a complete, stable, and jointly agreed requirements specification. All following requirement artifacts reflect the final state after all iterations.

== Overview
#TODO[
  Provide a short overview about the purpose, scope, objectives and success criteria of the system that you like to develop.
]
#GOAL[
  - Purpose
    - Provide a scalable and efficient solution for sharing large-scale pathology scans (20–30 GB per file) among medical experts globally.
    - Overcome current limitations posed by proprietary image formats and vendor-specific cloud platforms.
    - Enable fast, secure, and reliable second-opinion diagnostic workflows in digital pathology.
  - Scope
    - The system will facilitate secure and efficient upload, storage, and sharing of large pathology imaging files.
    - It will integrate seamlessly into existing clinical workflows by leveraging standard medical imaging protocols (DICOM, DICOMweb).
    - Out of scope
      - Direct replacement or modification of existing medical imaging scanners and laboratory hardware.
      - Full integration or replacement of existing hospital-wide PACS/LIS infrastructures.
  - Objectives
    - Reduce scan sharing time significantly (from hours to under x minutes).
    - Ensure interoperability with existing medical imaging standards (DICOM/DICOMweb).
    - Provide a vendor-neutral, cloud-based architecture supporting remote diagnostics workflows securely.
    - Facilitate ease of use for imaging technicians, clinicians, and remote diagnostic specialists.
  - Sucess criterias
    - Pathology scan transfer and retrieval completed consistently within the target time frame.
    - System validation demonstrates potential seamless interoperability with clinical PACS and LIS (might be mocked).
    - Positive usability feedback from stakeholders (imaging technicians, clinicians, external experts).
    - (Compliance with regulatory and security standards (GDPR, HIPAA, data encryption at rest and in transit).) - maybe, might be too much and didn't propose in proposal
]
The system aims to provide a scalable and efficient solution for sharing large-scale pathology scans in support of remote diagnostic workflows. It addresses limitations caused by proprietary formats and vendor-specific platforms, enabling fast, secure, and reliable second-opinion collaboration in digital pathology. The scope includes secure upload, storage, and sharing of high-resolution imaging files, with seamless integration into existing clinical workflows through established medical imaging standards. Hardware replacement and full-scale PACS/LIS substitution are excluded from the scope.

Key objectives are to reduce transfer times significantly, ensure interoperability with standard protocols, and deliver a vendor-neutral, cloud-based architecture that supports remote diagnostics while remaining easy to use for all involved medical professionals. Success will be measured by the system’s ability to meet defined performance targets for transfer and retrieval, demonstrate interoperability with clinical systems, and receive positive usability feedback from stakeholders.

== Existing System <ExistingSystem>
#TODO[
  This section is only required if the proposed system (i.e. the system that you develop in the thesis) should replace an existing system.
]
#GOAL[
  - Pathology scans (20–30 GB) are currently stored in a proprietary format generated by imaging scanners.
  - Scans must be uploaded to the manufacturer's proprietary cloud platform.
  - File transfers to external experts often take several hours, delaying critical diagnostic workflows.
  - Existing solutions are vendor-locked, inflexible, and not interoperable with other systems.
  - Limitations of Current Workflow:
    - Slow and unreliable data transfers (hours per file).
    - Lack of interoperability (cannot use different scanners with vendor platform), leading to inefficiencies.
    - Dependency on closed, proprietary software environments, restricting collaboration.
]

The current implementation of the image sharing solution for remote diagnostics at Synlab closely resembles the architectural components of modern medical imaging systems described by Huang in @MedicalImagingEcosystemSection @huang:2010:PACSImagingInformatics. The specific system architecture is shown in @SynlabExistingSystem. Unlike typical deployments where an application server provides external access to the PACS via a web viewer, Synlab connects an additional PACS that serves as a global image repository. This second PACS instance is deployed in a demilitarized zone (DMZ) within the corporate network. The DMZ acts as a controlled boundary that permits secure access by external experts via VPN tunnels while isolating internal clinical systems—such as the local PACS and other subsystems—from direct exposure.

#figure(
image("../figures/uml/thesis/synlab-existing-system.png", width: 100%),
caption: [Arcitectual components of the existing system implemented at Synlab. The difference to the medical imaging components in @MedicalImagingEcosystemSection is the separate global PACS to store anonymized images and the second opinion platform to perform the workflow. The image itself and second opinion related information are split up into two subsystems (UML component diagram).]
) <SynlabExistingSystem>

The global PACS differs from the local PACS mainly in its limited functionality. It does not include an acquisition gateway and cannot receive images directly from scanners. Instead, it provides a transfer service that allows local imaging staff to export scans from the internal PACS. During this transfer, all personal data—such as patient names—is anonymized to comply with data protection regulations. The global PACS also includes a viewing service. Unlike the local PACS, this viewer does not offer workflow features such as annotations or image editing. It is solely used by external experts to view diagnostic images via a web-based interface.

In addition to the PACS subsystem, Synlab operates a second opinion platform that handles the diagnostic workflow. As explained in @Problem, this platform enables pathologists to request the opinion of external specialists. It consists of an application server that manages metadata about second opinion cases, including the case status and expert feedback. Each case is linked to a specific scan in the global PACS through a lookup service. While this integration allows referencing of the image data, the two systems are managed separately and require users to manually align data between them during the workflow.

The second opinion platform includes a web interface that displays only case metadata, such as the assigned expert or current status. The diagnostic image itself is accessed via a hyperlink, which opens the relevant case ID in the viewer provided by the global PACS. Changes to the case, such as submitting the expert’s opinion or closing the case, are made through the platform’s workflow interface. Although the system is already deployed in a test environment, it is not yet in production. The current limitations, particularly regarding performance and usability, have prevented broader rollout and productive use across diagnostic teams.

The existing solution faces several structural issues that are already discussed in @Problem. Large image files lead to extended waiting times, especially when transferring scans from the local to the global PACS. The system lacks interoperability due to the proprietary and closed nature of the PACS software, making integration with third-party scanners infeasible. Moreover, the diagnostic workflow is fragmented. Users must first upload scans and then manually create second-opinion cases in a separate platform, linking them manually. This separation increases the risk of errors, reduces efficiency, and complicates daily operations. The system proposed in this thesis addresses these issues by offering an integrated and vendor-neutral alternative.


== Proposed System
#TODO[
  If you leave out the section “Existing system”, you can rename this section into “Requirements”.
]
#GOAL[
  - Functional and nonfunctional requirements outlined independently of technology.
  - Renamed 'Proposed System' to 'Requirements' as the existing system is important in the case of Synlab but the proposed system architecture will be developed in section 5
]
The proposed system addresses the limitations of the existing setup by introducing a vendor-neutral, cloud-based architecture designed for second-opinion workflows in digital pathology. It integrates image sharing and case management into a unified platform, enabling secure, scalable, and interoperable collaboration. The following artifacts—including functional requirements, quality attributes, and system constraints—were derived through requirements elicitation and subsequently refined in collaboration with the customer during validation.

=== Functional Requirements <FunctionalRequirements>
#TODO[
  List and describe all functional requirements of your system. Also mention requirements that you were not able to realize. The short title should be in the form “verb objective”

  - FR1 Short Title: Short Description. 
  - FR2 Short Title: Short Description. 
  - FR3 Short Title: Short Description.
]
#GOAL[
  - FR1 Upload Pathology Scans: Allow secure and rapid upload of large medical images (>20 GB per scan).
  - FR2 Share Scans Externally: Enable authorized external experts worldwide to quickly access high-resolution pathology scans.
  - FR3 Integrate Clinical Systems: Provide seamless integration with clinical workflows (PACS, LIS) using DICOM/DICOMweb standards.
  - FRs that are maybe not realized in the end but still considered
    - FRX Automatic Image Conversion: Direct automated conversion of all proprietary formats was excluded due to time/resource constraints.
    - FRX Manage Access and Permissions: Facilitate role-based access control (RBAC) tailored to clinicians, imaging technicians, and external experts.
    - FRX Notify Stakeholders: Automatically inform involved stakeholders (experts, clinicians) when scans are available or accessed.
]
Functional requirements describe the interactions between the system and its environment, independent of any specific implementation @bruegge:2010:ObjectorientedSoftwareEngineering. The environment includes users—such as imaging staff and external experts—as well as external systems involved in the second-opinion workflow. These requirements define the system’s observable behavior, focusing on user actions (e.g., uploading scans, requesting opinions) and system responses (e.g., granting access, logging events, issuing notifications). The following functional requirements were identified and refined over several iterations of requirements elicitation in collaboration with stakeholders.
- *FR1 — Upload Pathology Scans:* The system shall allow users to upload large medical image files, such as whole-slide pathology scans, when initiating a second-opinion request. The upload process must support files of 20–30 GB and ensure data integrity and anonymization.
- *FR2 — Request Second-Opinion:* The system shall allow users to initiate a second-opinion case by selecting one or more experts and providing relevant metadata, including diagnostic questions and areas of focus. The request is linked to the corresponding uploaded scan.
- *FR4 — Share Scans with External Experts:* The system shall enable secure sharing of pathology scans with authorized remote experts. Access must be restricted to selected experts and performed through a secure, authenticated channel.
- *FR4 — View Assigned Second-Opinion Cases:* Users shall be able to view a list of second-opinion cases in which they are involved, either as a requestor or as a responding expert. For each case, the current status and relevant metadata shall be displayed.
- *FR5 — View Pathology Scans:* Remote experts shall be able to access and view assigned scans using a viewer optimized for large, high-resolution images. The viewer must support smooth navigation and zoom functionalities.
- *FR6 — Provide Second Opinion:* Remote experts shall be able to submit a textual second opinion for a given case. The system shall associate this input with the corresponding scan and case metadata.
- *FR7 — Review Second-Opinion and Communicate:* The requestor shall be able to review the submitted second opinion in a structured format. If clarification is required, the system shall support communication between the requestor and the expert.
- *FR8 — Close Second-Opinion Case:* Once the second opinion is complete, the requestor shall be able to formally close the case. After closure, the case becomes read-only and is archived for audit and reference purposes.
- *FR9 — Anonymize Patient Data*: The system shall ensure that all personal identifiers are removed or anonymized before storing or sharing any scan externally. This requirement is critical for regulatory compliance.
- *FR10 — Monitor System Activity*: The system shall provide basic logging and monitoring functionality to trace actions related to second-opinion workflows. This includes uploads, case creation, sharing events, and submissions.
- *FR11 — Notify Users of Case Updates*: The system shall notify users of relevant updates in second-opinion cases. This includes notifications for new assignments, submitted opinions, clarification requests, or case closures.
Among these functional requirements, the ability to upload and share large pathology scans (FR1, FR3), manage second-opinion cases (FR2, FR4), and ensure secure access for external experts (FR5, FR9) form the core capabilities of the proposed system. Together, they enable a streamlined, secure, and scalable remote diagnostic workflow. The next section defines the quality attributes that further constrain how these functions must behave to meet clinical, technical, and regulatory expectations.

=== Quality Attributes
#TODO[
  List and describe all quality attributes of your system. All your quality attributes should fall into the URPS categories mentioned in @bruegge:2010:ObjectorientedSoftwareEngineering. Also mention requirements that you were not able to realize.

  - QA1 Category: Short Description. 
  - QA2 Category: Short Description. 
  - QA3 Category: Short Description.

]
#GOAL[
  - Usability
    - NFR1 Intuitive Interface: User interface must be intuitive for clinical and technical users without extensive training.
  - Reliability
    - NFR2 Fault-Tolerance: System must support resumable uploads/downloads reliably despite network interruptions.
  - Performance
    - NFR3 Data Transfer Efficiency: Transfers completed consistently under x minutes per file (20–30 GB).
    - NFR4 Scalability: System performance remains stable under increased concurrent usage (multiple simultaneous uploads/downloads).
  - NFRs that are maybe not realized in the end but still considered
    - Supportability
      - NFRX Ease of Maintenance: Easy deployment of system updates without causing significant downtime (target x min).
      - Security & Compliance
        - NFRX Regulatory Compliance: System must fully adhere to GDPR and HIPAA compliance guidelines.
        - NFRX Secure Data Transmission: All medical data transmitted must be encrypted (TLS).
        - NFRX Auditability: Support detailed logging for auditing purposes (user access logs, data actions).   
]
Quality attributes describe system properties that define how the system behaves under specific conditions rather than what the system does. They do not describe functionality but instead characterize system-wide aspects such as usability, performance, and reliability @bruegge:2010:ObjectorientedSoftwareEngineering. These requirements were identified alongside the functional requirements and validated iteratively with stakeholders. The quality attributes presented here ensure that the proposed system can be used effectively in real-world diagnostic workflows while remaining maintainable, secure, and scalable.
-	*QA1 — Usability:* The system shall provide a clean and intuitive interface that supports diagnostic workflows without requiring extensive training. Image viewing, case creation, and communication must be easy to perform, even for users without technical backgrounds. Terminology and workflows shall align with medical domain conventions.
-	*QA2 — Reliability:* The system shall operate reliably during high data loads and provide consistent availability. If a scan transfer or opinion submission fails, the system must notify the user and allow recovery or retry. Unexpected interruptions shall not result in data loss.
-	*QA3 — Performance:* The system shall support fast upload and access to large pathology scans (20–30 GB). The upload process should not exceed 30 minutes under standard network conditions, and scan rendering in the viewer shall occur within 5 seconds after load initiation. Key performance indicators must be met consistently to support time-sensitive diagnostics.
-	*QA6 — Supportability (Interoperability):* The system shall support standardized interfaces (e.g., DICOMweb) to ensure compatibility with diverse PACS systems, image viewers, and laboratory platforms. Proprietary formats must be converted where possible to enable standardized viewing and storage.
-	*QA7 — Supportability (Maintainability):* The system shall be modular and loosely coupled to enable isolated updates or replacements of individual components. Deployment scripts and infrastructure automation should support fast recovery and consistent rollouts in different environments.
-	*QA8 — Supportability (Scalability):* The system shall support increasing numbers of concurrent users and image transfers without degradation of performance. Both the application and storage layers must scale horizontally to accommodate growth.
Among the defined quality attributes, performance, and interoperability are particularly critical for the success of the proposed system. Fast image access, and compatibility with existing clinical infrastructure, are essential to support remote collaboration in digital pathology. The next section outlines specific constraints that further restrict the implementation and operation of the system, including technical, regulatory, and environmental factors.

=== Constraints

#TODO[
  List and describe all pseudo requirements of your system. Also mention requirements that you were not able to realize.

  - C1 Category: Short Description. 
  - C2 Category: Short Description. 
  - C3 Category: Short Description.

]
Constraints define mandatory conditions that restrict how the system may be designed, implemented, deployed, or operated. Unlike quality attributes, which describe desirable properties of the system’s behavior, constraints impose hard boundaries that must not be violated. These include technical decisions, external system interfaces, and legal or regulatory requirements. The following constraints were identified during requirements elicitation and confirmed through stakeholder discussions.
-	*C1 — Interface Constraint (Use of DICOM and DICOMweb):* The system shall rely on DICOM and DICOMweb standards for storing, retrieving, and displaying medical images to ensure interoperability with clinical imaging systems.
-	*C2 — Interface Constraint (Integration with Existing PACS):* The global PACS used for second-opinion workflows must remain compatible with Synlab’s existing vendor-specific PACS infrastructure. Direct modification of PACS internals is not permitted.
-	*C3 — Implementation Constraint (Cloud-Based Deployment):* The system shall be deployed in a cloud environment to support scalability, availability, and secure external access. On-premise deployment is not within the scope of this thesis.
-	*C4 — Implementation Constraint (No Modification of Hardware):* The system must operate independently of existing diagnostic workstations and image acquisition hardware. Integration must occur only at the software layer.
-	*C5 — Legal Constraint (Data Anonymization):* All personal health information must be anonymized before scans are made accessible to external experts. This constraint is required for compliance with data protection regulations such as GDPR.
These constraints significantly shape the design space of the proposed system by defining technical boundaries, legal obligations, and integration limitations. They must be taken into account when selecting technologies, designing components, and structuring the system architecture. The following section introduces the system models that were developed to reflect the functional requirements, quality attributes, and constraints outlined above.

== System Models
#TODO[
  This section includes important system models for the requirements.
]
The system models presented in this section are developed across the requirements elicitation and analysis phases. Scenarios and the use case model are created during elicitation to capture key user interactions and system functionality. Building on these artifacts, the analysis object model and dynamic model are developed in the analysis phase to formalize the system's structure and behavior. In parallel, user interface mockups were created to support early validation with stakeholders and to refine usability-related aspects. The following subsections present each of these models in detail.

=== Scenarios
#TODO[
  If you do not distinguish between visionary and demo scenarios, you can remove the two subsubsections below and list all scenarios here.

  *Visionary Scenarios*
  Describe 1-2 visionary scenario here, i.e. a scenario that would perfectly solve your problem, even if it might not be realizable. Use free text description.

  *Demo Scenarios*
  Describe 1-2 demo scenario here, i.e. a scenario that you can implement and demonstrate until the end of your thesis. Use free text description.
]
#GOAL[
  - Visionary Scenarios
    - Global Real-Time Diagnostic Collaboration: A pathologist requests a second opinion, and experts globally can immediately view and collaborate on scans in real-time without latency or format issues.
  - Demo Scenarios
    - Rapid Scan Sharing Workflow: Imaging technician uploads pathology scan to cloud system; external expert accesses and views scan remotely within x minutes, clearly demonstrating reduced latency compared to existing methods.
]

=== Use Case Model <UseCaseModel>
#TODO[
  This subsection should contain a UML Use Case Diagram including roles and their use cases. You can use colors to indicate priorities. Think about splitting the diagram into multiple ones if you have more than 10 use cases. *Important:* Make sure to describe the most important use cases using the use case table template (./tex/use-case-table.tex). Also describe the rationale of the use case model, i.e. why you modeled it like you show it in the diagram.
]
#GOAL[
  - Actors
    - Imaging Technician
    - Pathologist (internal clinician)
    - External Diagnostic expert
  - Use Cases (UML Use Case Diagram)
    - UC1 Upload Pathology Scans
    - UC2 Request Expert Second Opinion
    - UC3 Retrieve and Review Scans
    - use cases that are maybe not realized in the end but still considered
      - UCX Manage User Roles and Permissions (needs System Administrator as actor)
      - UCX Receive Notifications
]

=== Analysis Object Model <AnalysisObjectModel>
#TODO[
  This subsection should contain a UML Class Diagram showing the most important objects, attributes, methods and relations of your application domain including taxonomies using specification inheritance (see @bruegge:2010:ObjectorientedSoftwareEngineering). Do not insert objects, attributes or methods of the solution domain. *Important:* Make sure to describe the analysis object model thoroughly in the text so that readers are able to understand the diagram. Also write about the rationale how and why you modeled the concepts like this.

]
#GOAL[
  - Domain Objects (UML Class Diagram)
    - (Patient (attributes: ID, name, anonymization status)) - Still unsure if needed since we may only work with fully anonymized data and this data is managed in LIS
    - PathologyScan (attributes: scan ID, format, file size, upload timestamp, DICOM metadata)
    - Clinician/User (attributes: user ID, role) - maybe also permissions
    - ExternalExpert (inherits from Clinician/User; specific attributes: affiliated institution) - probably makes sense to merge with clinician since it clinicians should also be able to give 2nd opinion, clarify this
    - DiagnosticReport (attributes: associated scan, comments, timestamps, status)
]

=== Dynamic Model
#TODO[
  This subsection should contain dynamic UML diagrams. These can be a UML state diagrams, UML communication diagrams or UML activity diagrams.*Important:* Make sure to describe the diagram and its rationale in the text. *Do not use UML sequence diagrams.*
]
#GOAL[
  - UML State Diagram (File Transfer Lifecycle)
    - States: "Pending," "Uploading," "Uploaded," "Processing," "Available," "Accessed," "Completed."
    - explanation of transitions in text, e.g. 'file accessed by external expert'
  - UML Activity Diagram (Second Opinion Workflow)
    - Steps: Request initiated → Scan uploaded → (Notification sent) → Expert accesses scan → Review completed
]

=== User Interface <UserInterface>
#TODO[
  Show mockups of the user interface of the software you develop and their connections / transitions. You can also create a storyboard. *Important:* Describe the mockups and their rationale in the text.
]
#GOAL[
  - Scan Upload Interface
    - Interface allowing technicians to select, upload scans, track progress.
  - Scan Retrieval Interface
    - Interface for external experts: scan access and viewing (and maybe login, notifications, ...)
  - (if permissions and roles are implemented) Admin Panel
    - Interface to manage users, roles, and monitor activities (audit logs, user management).
]