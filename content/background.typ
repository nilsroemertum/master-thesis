#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Background
#TODO[
  Describe each proven technology / concept shortly that is important to understand your thesis. Point out why it is interesting for your thesis. Make sure to incorporate references to important literature here.
]
#GOAL[
  - Explain technical foundations for
    - Large-scale medical imaging.
    - Technologies to share this data.
    - Data Privacy & Security.
    - Interoperability.
]

== Medical Imaging Ecosystem
#GOAL[
  - Proprietary formats issues.
  - Clinical Workflow: PACS and LIS Integration.
  - Proprietary Formats and Challenges.
  - UML Component Diagram showing major system components (PACS, LIS, viewer, interfaces).
]

== Medical Imaging Standards
#GOAL[
  - DICOM Standard Overview.
  - DICOMweb: Web-based Imaging Access.
  - Complementary Standards (HL7/FHIR).
]

== Interoperability in Healthcare
#GOAL[
  - Definition and Importance of Interoperability.
  - Levels of Interoperability (technical, syntactic, semantic).
  - Interoperability Challenges in Current Systems (vendor lock-in, proprietary formats).
]

== Data Privacy and Security in Medical Imaging
#GOAL[
  - (maybe leave out since privacy (e.g. anonymization) and security is not the primary subject of this thesis)
  - Regulatory Frameworks (GDPR, HIPAA, local regulations).
  - Patient Data De-identification Methods.
  - Secure Data Storage and Transmission Practices (TLS, encryption at rest, encryption in transit).
]

== Cloud Technologies for Medical Data
#GOAL[
  - Cloud Storage Fundamentals (Object Storage, Encryption).
  - Large File Transfer Techniques (Chunking, Compression, Resumable Uploads).
  - Cloud-based Compliance and Security Considerations
]

/**
== e.g. User Feedback
#TODO[
  This section would summarize the concept User Feedback using definitions, historical overviews and pointing out the most important aspects of User Feedback.
]

== e.g. Representational State Transfer
#TODO[
  This section would summarize the architectural style Representational State Transfer (REST) using definitions, historical overviews and pointing out the most important aspects of the architecture.
]

== e.g. Scrum
#TODO[
  This section would summarize the agile method Scrum using definitions, historical overviews and pointing out the most important aspects of Scrum.
]
**/