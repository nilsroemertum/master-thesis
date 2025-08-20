#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Related Work <RelatedWork>
#TODO[
  Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was already solved by XYZ.” If you have multiple related works, use subsections to separate them.
]
#GOAL[
  - Review existing architectures and solutions addressing large-scale medical imaging data sharing.
  - Identify strengths and limitations of current web-based and cloud-based solutions.
  - Evaluate interoperability challenges described in academic and industry literature.
  - Highlight key security and compliance practices previously applied to medical data sharing.
  - Clearly articulate the research gap this thesis addresses, setting the foundation for the proposed solution.
]
The shift towards standardized, interoperable imaging systems has been a recurring topic in academic research. Multiple papers have addressed specific technical aspects—such as vendor-neutral image repositories, web-based image visualization, or cloud-native PACS platforms—but often in isolation and without addressing the specific workflow requirements of remote diagnostics. In contrast, this thesis integrates these dimensions to support real-world diagnostic collaboration, particularly second-opinion workflows in digital pathology. The following subsections highlight key contributions in these areas and explain how this thesis extends the state of the art.

== Vendor-Neutral PACS Architecture <VendorNeutralPACSArchitecture>
Marques Godinho et al. present an architecture for integrating digital pathology into general-purpose PACS using exclusively DICOM-compliant communications and data formats @marquesgodinho:2017:EfficientArchitectureSupport. Their approach leverages preprocessing the images that come from the scanner (e.g., compression or conversion of files into DICOM format) before it is uploaded into the PACS to enable efficient processing of high-volume files. They further show that DICOM image formats and communication protocols can meet performance demands typically associated with proprietary solutions—like the image format JPEG2000. 

As a PACS solution they chose Dicoogle, an open source project offering a plugin-based architecture and a software development kit @marquesgodinho:2017:EfficientArchitectureSupport. It is intended to support the research and development of new PACS components and applications and will also be used for the prototypical implementation in this work. In addition, the compression of images in preprocessing is fundamental to increasing performance and efficient storage in medical imaging and is therefore ubiquitous in research @zarella:2018:PracticalGuideWhole. Finally, the web-based viewing application can search and display images stored in the PACS. A simplified version of this architecture is illustrated in @DicooglePathologyPACSArchitecture.

#figure(
  image("../figures/uml/thesis/dicoogle-pathology-pacs-architecture.png", width: 100%),
  caption: [Vendor-neutral PACS architectur for pathology images as proposed by @marquesgodinho:2017:EfficientArchitectureSupport. Images coming from the image scanner are preprocessed before they are uploaded into the PACS to ensure performance and DICOM-compliance. The web viewer then queries the image repositor and displays the requested images (UML component diagram).]
) <DicooglePathologyPACSArchitecture>

The architecture that is to be developed can benefit from this work since there is a trend to store large pathology images in PACS instead of proprietary repositories and the authors claim that the architecture they developed is the first attempt at building an architecture that resorts uniquely to the DICOM standard. Another advantage is the usage of an open-source PACS solution that is highly customizable and often used in research supports. This supports the use of vendor-neutral systems to maximize modularity and ensure interoperability across diverse clinical environments.

However, their architecture assumes a centralized PACS and does not address distributed collaboration workflows across institutional boundaries, nor does it integrate additional clinical context such as LIS data. Although the solution adopts pure web technologies to support deployment in cloud environments, it does not implement a cloud-native architecture that would enable benefits such as scalability, or performance. In contrast, this thesis proposes a modular architecture explicitly designed to enable remote second-opinion diagnostics by integrating DICOM, DICOMweb, and FHIR interfaces.

== Pathology Imaging Platform

Jesus et al. develop a cloud-enabled digital pathology platform also based on the open-source Dicoogle PACS and a modular web architecture @jesus:2023:PersonalizableAIPlatform. Their system supports AI-assisted workflows and enables web-based access to DICOM-compliant images. Image Scanners upload the scans to the PACS. Analysis provider like AI-based anomaly detection fetch and process those images. The application server pathology platform then retrieves the scan and the associated analysis. The results can be displayed in the image viewer. @PathologyAIPlatform illustrates the simplified component architecture as suggested in their work.

#figure(
  image("../figures/uml/thesis/cloud-based-pathology-ai-platform.png", width: 100%),
  caption: [Digital pathology platform as proposed by @jesus:2023:PersonalizableAIPlatform. The PACS provide an interface that is used by the image application server and the analysis provider to perform different kinds of computation on the scans (UML component diagram).]
) <PathologyAIPlatform>

The architecture demonstrates the feasibility of modular Dicoogle extensions and introduces a web-based platform for pathology imaging. It enables AI-assisted workflows and interactive image viewing through standard web technologies. However, the system does not address key requirements for remote diagnostic collaboration. It lacks LIS integration, limiting its applicability in clinical workflows. While it is based on web technologies, it does not adopt a fully cloud-native architecture—same as the preceding approach (see @VendorNeutralPACSArchitecture).

The platform also focuses primarily on AI integration rather than enabling robust diagnostic workflows across institutions. Although it incorporates efficient techniques for image access, it does not evaluate performance for large pathology files nor compare the effectiveness of its methods under realistic constraints. In summary, the work provides a valuable foundation for modular and standards-based development but does not cover the operational and architectural aspects necessary to support real-world diagnostic collaboration.

== Cloud-Native PACS System Design

Kawa et al. present a modern PACS architecture that is fully designed for the cloud @kawa:2022:DesignImplementationCloud. Their system moves away from traditional, monolithic PACS by using microservices and message-based communication to improve scalability, reliability, and performance. The architecture separates different tasks into smaller, independent components that can run in parallel and be scaled individually. It stores medical images in cloud storage systems and uses technologies like Apache Kafka (event-streaming platform) to manage data flow efficiently.

The system is tested with large amounts of imaging data and shows strong performance, especially under high load and parallel access. Benchmarks confirm that the architecture handles large-scale image transfers more effectively than older PACS solutions, demonstrating that cloud-native technologies can improve performance in demanding imaging environments. However, the focus remains only on the PACS itself. The architecture does not integrate with other clinical systems like LIS, nor does it support remote diagnostic workflows across institutions—same as the previous approaches.

== Summary and Gap Analysis
Existing research has explored a wide range of technical solutions for managing medical imaging data. Prior work has demonstrated vendor-neutral PACS designs based on DICOM standards, web-based platforms enabling image visualization and AI-assisted analysis, as well as fully cloud-native PACS architectures optimized for scalability and performance. These approaches provide valuable contributions to modular system design, standards compliance, and infrastructure efficiency.

However, the reviewed architectures focus primarily on isolated aspects without addressing the end-to-end requirements of remote diagnostic collaboration. They are often limited to specific components within the imaging pipeline and do not provide a holistic view of how different systems must interact in distributed clinical settings. In particular, they lack integration with broader clinical systems and do not consider the workflow-specific constraints associated with distributed second-opinion diagnostics.

This thesis addresses the identified gaps by building on a vendor-neutral PACS foundation and adopting a modular, cloud-based system architecture. It extends existing designs by integrating established standards to enable seamless communication with clinical systems. Particular attention is given to performance aspects relevant for handling large-scale files. The resulting architecture is tailored to the specific requirements of second-opinion diagnostics in digital pathology.