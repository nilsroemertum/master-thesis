#import "/utils/todo.typ": TODO

= Objective
The objective of this thesis is to design, implement, and evaluate a scalable, interoperable architecture for medical imaging that supports real-world diagnostic collaboration. The project builds upon existing work while extending and validating it within a pathology-focused use case. The specific goals of this thesis are:

1. Analyze existing technologies, standards, and architectures.
2. Design a scalable architecture for medical imaging.
3. Implement a prototype system.
4. Validate the architecture and prototype.

== Analyze existing technologies, standards, and architectures
This thesis begins with a structured analysis of current medical imaging infrastructures, focusing on interoperability, security, vendor neutrality, and clinical performance. Key areas include standards like DICOM/DICOMweb, open-source platforms, and research on cloud-based systems.

The goal is to identify strengths, limitations, and design patterns, with emphasis on technologies that support fast, secure transfer and viewing of large image files. The findings will inform architecture decisions and define technical requirements for remote diagnostics.

== Design a scalable architecture for medical imaging
The second goal is to design an architecture that enables timely, secure sharing of high-resolution images in diagnostic workflows, such as second-opinion use cases in digital pathology.

The design will support large file transfers, vendor-neutral interoperability, and integration with clinical systems like PACS and LIS. It will emphasize scalable storage, secure data exchange, and usability for imaging staff and remote experts—ensuring practical, cross-institutional collaboration.

== Implement a prototype system
The third goal is to build a prototype simulating a diagnostic workflow, including image acquisition, transfer, storage, and remote access. It will use open-source or existing technologies (e.g., DICOMweb, secure transfer) in a modular, replicable setup.

The implementation will follow the proposed architecture using realistic data and clinical constraints, forming the basis for testing and validation.

== Validate the architecture and prototype
The final goal is to evaluate the architecture in a realistic remote diagnostics scenario, focusing on scan availability, user experience, integration, and performance (e.g., transfer and response times).

Feedback from stakeholders like technicians and medical experts will guide the assessment, demonstrating the system’s impact and identifying areas for improvement.