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
The following chapter introduces essential background topics necessary to understand current developments and challenges in medical imaging. Huang provides a foundational overview of the principles behind PACS and their role in modern imaging workflows @huang:2010:PACSImagingInformatics. Mildenberger et al. outline the significance of established standards in medical imaging, with a particular focus on the DICOM standard @mildenberger:2002:IntroductionDICOMStandard. Mendelson et al. and Iroju et al. contribute critical insights into interoperability challenges and their implications for healthcare information systems @mendelson:2014:ImageSharingEvolving @iroju:2013:InteroperabilityHealthcareBenefits. These sources provide the conceptual basis for the subsequent discussion, which highlights the relevance of each topic for designing a scalable and interoperable architecture in medical imaging.

== Medical Imaging Ecosystem
#GOAL[
  - Proprietary formats issues.
  - Clinical Workflow: PACS and LIS Integration.
  - Proprietary Formats and Challenges.
  - UML Component Diagram showing major system components (PACS, LIS, viewer, interfaces).
]
Huang already provides an extensive description of the architectural components used in modern medical imaging systems @huang:2010:PACSImagingInformatics. Building on this foundation, @MedicalImagingEcosystem illustrates a representative configuration of a typical PACS ecosystem. This figure reflects a generalized model commonly found in clinical environments. Actual implementations may vary depending on institutional requirements. For instance, some setups may exclude remote workflows or omit integration with LIS.

#figure(
  image("../figures/uml/thesis/medical-imaging-ecosystem-components.png", width: 100%),
  caption: [Components of the medical imaging ecosystem adapted from @huang:2010:PACSImagingInformatics. The component diagram illustrates the typical structure of a PACS-based imaging infrastructure, including key components such as gateways, PACS servers and LIS integration. It emphasizes the data flow between image-producing devices, metadata repositories, and diagnostic workstations, highlighting the technical interfaces that enable both local and remote  workflow collaboration (UML component diagram).]
) <MedicalImagingEcosystem>

A medical imaging ecosystem connects imaging modalities, storage, and diagnostic review systems with clinical information sources. Related patient and case metadata are typically managed in an LIS. To associate a scan with this metadata, the PACS system first fetches the necessary information through a database gateway. This ensures that all acquired images can be linked to the correct clinical context, supporting consistent case management throughout the diagnostic process.

Imaging devices, such as pathology scanners, produce high-resolution images and forward them to the PACS. An image scanner retrieves contextual information by communicating with the LIS via the database gateway. After image acquisition, the data must be integrated into the PACS. This is achieved using an acquisition gateway, which converts image data from device-specific formats into a PACS-compliant structure. It then transmits the resulting data to the PACS server.

The acquisition gateway supports both push and pull mechanisms for data transfer. In pull mode, the acquisition system initiates the transfer. This mode improves fault tolerance by allowing retries in case of temporary failures. If the acquisition gateway becomes unavailable, imaging devices can temporarily queue studies and retry transfers later or reroute them to a backup gateway. @MedicalImagingEcosystem illustrates the pull mode.

After the acquisition step, the images are sent to the PACS server and archive, which serves as the central engine of the ecosystem. It includes a database server for metadata and an archive system for image storage. This server provides access to internal and external systems through various services. For local users, PACS workstations allow interactive access to images, enabling diagnostic review, annotation, and workflow management.

Through the workflow interface, the PACS server supports connections with external systems. Application servers can be attached to enable remote access, for example via web-based viewers. These external viewers support decentralized collaboration across different institutions. Changes performed during image review—such as annotations or diagnostic results—are reflected in the PACS and, when relevant, transmitted to the LIS (e.g., current status of the scan or diagnoses).

This modular ecosystem enables flexible image management, supporting both local diagnostics and remote second-opinion consultations via application servers. Its modularity allows individual components to be adapted or extended independently, facilitating integration with heterogeneous systems and evolving clinical needs @meyer-ebrecht:1994:PictureArchivingCommunication. While this structure forms a robust foundation, current implementations still face challenges—such as proprietary formats and limited interoperability—that must be addressed to enable scalable, cross-institutional diagnostic collaboration.

== Medical Imaging Standards <MedicalImagingStandards>
#GOAL[
  - DICOM Standard Overview.
  - DICOMweb: Web-based Imaging Access.
  - Complementary Standards (HL7/FHIR).
]
Medical imaging standards define how image data is structured, transmitted, and interpreted within and across clinical systems. These standards enable interoperability among heterogeneous devices and healthcare institutions, ensuring consistent integration into clinical workflows and long-term image management. Among these, the Digital Imaging and Communications in Medicine (DICOM) standard has emerged as the most relevant and widely adopted framework for handling, exchanging, and interpreting medical imaging data @mildenberger:2002:IntroductionDICOMStandard.

DICOM plays a central role in pathology and is increasingly used in other medical fields like radiology. It defines both the image file format and the network communication protocol between imaging modalities, PACS and workstations. This dual specification ensures that image data and metadata can be exchanged independently of the manufacturer, enabling robust integration between scanners, viewers, and archives.

The introduction of DICOM version 3.0 in 1993 marked a fundamental shift toward open communication. Earlier, image exchange relied on proprietary interfaces that limited interoperability. Version 3.0 adopted the ISO/OSI model and introduced support for TCP/IP-based communication. Although current references no longer mention version numbers, this architecture remains the foundation of DICOM implementations today.

Technically, DICOM spans several OSI layers. It defines an Upper Layer Protocol (ULP) over TCP/IP to transmit image data, services, and metadata. Each image file is accompanied by a header that contains structured attributes, such as patient information or procedure metadata. This approach ensures that all diagnostic context is transferred alongside the image, encapsulated as a single, self-describing object.

DICOM does not prescribe how data should be stored, managed, or displayed. Instead, it defines which information elements are required for transmission and how they are encoded @mildenberger:2002:IntroductionDICOMStandard. This flexibility enables institutions to implement DICOM within diverse IT environments, while ensuring compatibility at the communication layer. It forms the technical basis for PACS integration and is essential for any architecture that supports cross-vendor image exchange.

To support modern web and cloud environments, the standard has evolved into DICOMweb, a set of RESTful services that expose DICOM functionality through HTTP @genereaux:2018:DICOMwebBackgroundApplication. These services enable browser-based access to imaging data and are designed to work with standard web technologies and formats like JSON, XML, and HTTPS. DICOMweb removes the need for thick clients or VPNs and allows seamless integration with lightweight frontends or third-party systems, making it highly relevant for cloud-native diagnostic workflows.

Beyond image data itself, healthcare systems need to exchange structured clinical information such as findings in pathology scans. This is handled by the Fast Healthcare Interoperability Resources (FHIR) standard. FHIR defines RESTful APIs for the exchange of clinical resources and supports modern serialization formats like JSON and XML. It is commonly used to integrate LIS with PACS or other systems, enabling the consistent linkage of image data with diagnostic orders or pathology findings.

Understanding these standards is essential for the development of scalable and interoperable imaging infrastructures. In this thesis, DICOM is used for the exchange of diagnostic images between image modalities and PACS. DICOMweb extends this capability into modern web environments and is used for web-based applications. FHIR is used to transmit structured patient and order information between PACS and LIS. The communication between these systems is visualized in @MedicalImagingStandardsCommunication, which illustrates how those standards interact within the medical imaging ecosystem.

#figure(
  image("../figures/uml/thesis/medical-imaging-standards-communication.png", width: 100%),
  caption: [Exemplary communication between a pathologist and objects of the medical imaging infrastructure. The communication diagram illustrates the different standards used for data exchange based on desciptions in @mildenberger:2002:IntroductionDICOMStandard. Compare with @MedicalImagingEcosystem, as the objects represent the components in the medical imaging ecosystem. The pathologist initiates a scan using a scan identifier, which may originate from a LIS. The image modality stores the scan in a DICOM-compliant format and transmits it to the local PACS using the DICOM protocol. The PACS subsequently retrieves supplementary metadata from the LIS via the FHIR protocol and receives the information in a FHIR-compliant structure. To access the scan remotely, the pathologist uses a web viewer, which queries the PACS using the DICOMweb standard and receives the image in a DICOM-compliant format. For simplicity, intermediate communication steps and confirmation messages are omitted in the diagram (UML communication diagram).]
) <MedicalImagingStandardsCommunication>

The standards DICOM and FHIR are often implemented in isolation, which can lead to integration challenges in practice. The Integrating the Healthcare Enterprise (IHE) initiative addresses this gap -by providing harmonized implementation profiles. IHE defines how to apply existing standards, such as DICOM and FHIR, to solve specific clinical use cases. For example, the IHE XDS-I.b profile describes how to perform cross-enterprise image sharing in a consistent, standards-compliant way. These profiles improve system interoperability and reduce ambiguity during integration.

== Interoperability in Healthcare <InteroperabilityInHealthcare>
#GOAL[
  - Definition and Importance of Interoperability.
  - Levels of Interoperability (technical, syntactic, semantic).
  - Interoperability Challenges in Current Systems (vendor lock-in, proprietary formats).
]
Interoperability is critical for diagnostic workflows involving multiple institutions and systems. In digital pathology, cases regularly require interaction between imaging personnel, local diagnosticians, and remote experts. Effective collaboration depends on the ability to exchange both image data and clinical metadata across heterogeneous infrastructures without loss of context or meaning.

Despite the availability of interoperability standards, practical implementation remains challenging. Mendelson et al. define interoperability as the ability to exchange data accurately and meaningfully between systems @mendelson:2014:ImageSharingEvolving. However, many healthcare environments rely on isolated, vendor-specific systems without open interfaces. Even when standards are used, inconsistent adoption, proprietary extensions, and misaligned semantics often prevent seamless integration @iroju:2013:InteroperabilityHealthcareBenefits.

The parallel use of DICOM, FHIR, and legacy systems further complicates integration. DICOM enables image exchange, while FHIR supports structured clinical metadata. However, local adaptations and differing interpretations of these standards introduce ambiguity. Legacy systems, which are typically not designed for interoperability, persist due to high switching costs and operational dependencies. Many of these systems are closed by design, limiting connectivity with external tools.

Addressing these issues requires more than standard compliance. Interoperable architectures must encapsulate legacy systems, align data models, and manage integration across varied technologies. Cloud platforms can expose vendor-neutral APIs and isolate internal complexity. IHE profiles (see @MedicalImagingStandards) help guide consistent standard use for specific clinical scenarios. Practical interoperability depends on designing solutions that work reliably within the fragmented and evolving realities of clinical IT environments.

== Cloud Technologies for Medical Imaging
#GOAL[
  - Cloud Storage Fundamentals (Object Storage, Encryption).
  - Large File Transfer Techniques (Chunking, Compression, Resumable Uploads).
  - Cloud-based Compliance and Security Considerations
]
Cloud-based technologies have become essential for modern medical imaging workflows, particularly in scenarios requiring cross-institutional collaboration. By decoupling diagnostic image access from on-site storage, they allow medical professionals to retrieve and review high-resolution imaging data regardless of location. Cloud platforms provide a scalable and flexible foundation that traditional PACS systems fail to offer, supporting both the storage and high-speed delivery of diagnostic images in a distributed healthcare environment @zarella:2018:PracticalGuideWhole @liu:2016:IMAGECloudMedical.

The integration of cloud-based image sharing into clinical workflows enhances both the efficiency and quality of diagnostics. As Flanagan et al. note, cloud platforms improve diagnostic decision-making by providing easy access to both current and historical imaging studies, which supports more informed clinical evaluations @flanagan:2012:UsingInternetImage. In addition, cloud platforms mitigate the risk of lost images and support uninterrupted collaboration between experts from different institutions. For pathology specifically, this facilitates the consultation of external specialists without the delays and inefficiencies caused by physical slide transportation.

However, leveraging the advantages of cloud infrastructure requires adherence to specific technical and regulatory standards. As Mendelson et al. emphasize, cloud-based systems must support established standards such as DICOM and DICOMweb to ensure interoperability with PACS, viewers, and LIS already in use (see @MedicalImagingStandards and @InteroperabilityInHealthcare) @mendelson:2014:ImageSharingEvolving. Moreover, robust data security measures must be implemented. For instance, image data should be stored in facilities that meet regulatory requirements such as HIPAA compliance. The Health Insurance Portability and Accountability Act (HIPAA) defines standards for protecting sensitive patient data, including provisions for secure data storage.

After outlining the key concepts relevant to medical imaging that directly inform the architectural choices explored in this thesis, the next chapter examines existing research and technological approaches in the field. With a clear understanding of foundational topics such as interoperability, imaging standards, and cloud-based architectures, the related work will be critically assessed in light of these requirements. This analysis provides the basis for identifying limitations in current approaches and motivates the design and implementation choices presented in the subsequent chapters.

/**
 * == Data Privacy and Security in Medical Imaging
#GOAL[
  - (maybe leave out since privacy (e.g. anonymization) and security is not the primary subject of this thesis)
  - Regulatory Frameworks (GDPR, HIPAA, local regulations).
  - Patient Data De-identification Methods.
  - Secure Data Storage and Transmission Practices (TLS, encryption at rest, encryption in transit).
]

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