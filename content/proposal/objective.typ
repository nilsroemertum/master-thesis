#import "/utils/todo.typ": TODO

= Objective
The objective of this thesis is to design, implement, and evaluate a scalable, interoperable architecture for medical imaging that supports real-world diagnostic collaboration. The project builds upon existing work while extending and validating it within a pathology-focused use case. The specific goals of this thesis are:

1. Analyze existing technologies, standards, and architectures for interoperable and secure medical imaging.
2. Design an architecture tailored to high-resolution medical imaging with a focus on data sharing workflows.
3. Implement a prototype system based on the proposed architecture using realistic data and clinical constraints.
4. Validate the architecture and prototype in a practical use case with regard to diagnostic workflows, stakeholder needs, and system performance.

== Analyze existing technologies, standards, and architectures for interoperable and secure medical imaging.

The first goal of this thesis is to provide a structured and comprehensive analysis of existing approaches to medical imaging infrastructure, focusing on interoperability, vendor neutrality, and performance under clinical constraints. This includes studying standards such as DICOM (including DICOMweb), relevant open-source platforms, and prior research on cloud-based imaging systems.

The analysis will identify strengths, limitations, and common patterns, and serve as a basis for decisions made in the architecture design phase. In particular, technologies that enable fast, secure transfer and viewing of large image files will be of central interest. The outcome of this step will be a synthesized set of technical requirements tailored to the specific use case of digital pathology and remote diagnostics.

== Design an architecture tailored to high-resolution medical imaging with a focus on data sharing workflows.

The second goal is to design an architecture that addresses the specific challenges of sharing high-resolution medical images in collaborative diagnostic environments. Building upon existing standards and prior architectural proposals, this thesis extends the current knowledge by focusing on workflows where timely and secure image access is critical—such as second-opinion scenarios in digital pathology.

The architecture will be shaped to support large file transfers, vendor-independent interoperability, and seamless integration into clinical routines. Key aspects include scalable storage, secure and performant data exchange mechanisms, and compatibility with established systems like PACS and LIS. Special emphasis will be placed on the usability and accessibility of the architecture for various stakeholders, including imaging staff and remote medical experts, ensuring the solution supports real-world data sharing needs across institutional boundaries.

== Implement a prototype system based on the proposed architecture using realistic data and clinical constraints.

The third goal involves implementing a functional prototype of the proposed architecture together with Synlab. The prototype will simulate a real diagnostic workflow, including image acquisition, transfer, storage, and remote access. This implementation will integrate open-source or existing technologies (e.g., DICOMweb servers, viewers, secure file transfer) in a modular and replicable fashion.

The implementation will be guided by the previously defined requirements and use real-world data formats and constraints wherever possible. It will serve as the basis for performance testing and validation.

== Validate the architecture and prototype of the practical use case with regard to diagnostic workflows, stakeholder needs, and system performance.

The final goal is to validate the system in a realistic use case, focusing on the domain of digital pathology. The validation will assess how well the architecture supports remote diagnostic collaboration, with particular attention to scan availability, user experience, integration feasibility, and performance metrics (e.g., data transfer time, system response time).

Stakeholder perspectives—such as imaging technicians, medical experts, and clinicians—will guide the evaluation. This step will demonstrate the architecture's potential impact on medical imaging workflows and highlight areas for further development or generalization.