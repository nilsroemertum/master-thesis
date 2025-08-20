#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Introduction <Introduction>
#TODO[
  Introduce the topic of your thesis, e.g. with a little historical overview.
]
#GOAL[
  - Brief history of medical imaging and relevance in diagnostics.
  - Growing importance of remote diagnostics and global collaboration (consolidation of labs, medical service specialization) - Just intro, more extensive in 1.2 Motivaion.
]
Medical imaging has fundamentally transformed diagnostic medicine since Wilhelm Conrad Roentgen’s discovery of X-rays in 1895. He observed that these invisible rays could penetrate human tissue but were absorbed by denser materials such as bone and metal. This discovery marked the birth of medical imaging and earned Roentgen the first Nobel Prize in Physics in 1901. Since then, the field has advanced significantly, encompassing a range of modern modalities such as computed tomography (CT), magnetic resonance imaging (MRI), ultrasound, and positron emission tomography (PET), all of which enable clinicians to visualize internal anatomy and pathology with high precision and minimal invasiveness @bradley:2008:HistoryMedicalImaging.

As the capabilities of imaging technologies have grown, so has their role in enabling collaborative diagnosis. Remote diagnostics refers to the transmission of medical data—including clinical images—across geographic distances between medical experts for consultation. Initially developed for military applications to support medical personnel aboard naval ships, it has since become an established approach for facilitating timely diagnoses and specialist input.

Beyond improving access in remote settings, remote diagnostics enhances cost-effectiveness by reducing unnecessary patient transfers and enabling efficient resource allocation. It allows medical experts to participate in care delivery independent of their physical location, making specialist knowledge globally accessible @stevens:1982:RemoteMedicalDiagnosis. These developments place increasing demands on the digital infrastructure that underpins diagnostic collaboration—demands that current systems often fail to meet.

== Problem <Problem>
#TODO[
  Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]
#GOAL[
  - Current solutions PACS are inflexible and slow when it comes to large-scale medical imaging workflows
    - Long file transfers
    - Lack of interoperability for different scanner vendors
    - Limited options for remote experts (not tailored to specific needs during the workflow)
  - Business side: Lab consoludations, medical service specialization.
  - Technology side: Existing legacy architectures not ready for this new workflow (see first bullet point)
  - Academic gap: No existing architecture tailored for large pathology scan sharing.
]
Remote diagnostic workflows depend on Picture Archiving and Communication Systems (PACS), which serve as the backbone for storing, accessing, and distributing medical images across institutions @huang:2010:PACSImagingInformatics. Together with other systems that manage clinical and administrative data—such as laboratory Information systems (LIS)—PACS form the digital infrastructure for managing clinical data and supporting diagnostic workflows. By enabling digital access to imaging data, PACS play a central role in facilitating collaboration between geographically distributed medical professionals @meyer-ebrecht:1994:PictureArchivingCommunication.

A representative example of remote diagnostic collaboration can be observed in the workflows of Synlab, one of Europe’s largest medical diagnostic service providers. Synlab operates a network of laboratories that utilize PACS and LIS to facilitate international exchange of diagnostic data#footnote[https://www.synlab.com/lablocator], particularly in the field of digital pathology. One frequent scenario is the second-opinion consultation, in which a pathologist seeks input from an external expert to validate or refine a diagnosis. This collaborative process is especially relevant for complex or rare cases where additional expertise may improve diagnostic accuracy and inform treatment decisions @farooq:2021:AssessingValueSecond.

Growing reliance on remote diagnostics and increasing data volumes reveal the limitations of current architectures. As diagnostic collaboration becomes more distributed and data-intensive, existing systems struggle to meet the performance, interoperability, and workflow demands of modern clinical practice. The increasing complexity of such diagnostic environments calls for a closer examination of the structural deficiencies present in current solutions. 

=== Limited Support for Large-Scale Images

The volume of medical image data continues to increase rapidly, evolving from kilobytes to terabytes, with petabyte-scale workloads already on the horizon. This trend is driven by advances in imaging technologies that produce ever higher resolutions and more complex datasets. As noted by Scholl et al., this growth presents serious challenges for image management, processing, and visualization, demanding scalable architectures and algorithms capable of handling massive data volumes efficiently @scholl:2011:ChallengesMedicalImage.

As image sizes and numbers continue to grow @smith-bindman:2008:RisingUseDiagnostic, PACS increasingly struggle with transmission inefficiencies and network-related constraints @lameira:2024:TransversalPACSBrowser. Liu et al. and Alhajeri et al. both emphasize that larger datasets intensify these challenges, leading to overloaded infrastructure, repeated transfer failures, and workflow disruptions that compromise timely access to diagnostic images @liu:2014:PerformanceEnhancementWebBased @alhajeri:2019:LimitationsSolutionsImproving. New architectures are required to support the high-speed sharing of large-scale medical images across distributed clinical environments, as traditional PACS solutions are increasingly obsolete due to their limited scalability and inability to support multi-institutional workflows @lebre:2020:CloudReadyArchitectureShared.

In practice, Synlab’s second-opinion workflows involve pathology images that typically range from 20 to 30 GB in size per scan. These high-resolution files are generated in proprietary formats and are uploaded to vendor-specific cloud platforms for external access. The upload process alone often takes several hours, creating significant delays in the diagnostic cycle. Transmission problems such as unstable connections exacerbate these delays and increase the risk of failed transfers.

=== Lack of System Interoperability
Modern healthcare systems face growing interoperability challenges as they become increasingly reliant on complex, heterogeneous infrastructures. As Aceto et al. note, this complexity—driven by diverse and proprietary technologies—results in fragmented architectures that lack standardized interfaces, making integration across systems difficult @aceto:2018:RoleInformationCommunication. 

These issues are further amplified by the intrinsic complexity of the healthcare domain, which involves numerous stakeholders—such as clinicians, laboratories, and administrative systems—generating diverse types of data that must be exchanged reliably and meaningfully. In addition, ongoing standardization issues and the widespread use of legacy systems—often designed with proprietary formats and closed interfaces—continue to hinder interoperability, as many vendors deliberately restrict compatibility to protect market share and promote full-system purchases by hospitals and clinical networks @iroju:2013:InteroperabilityHealthcareBenefits.

Synlab’s second-opinion workflow highlights the real-world consequences of these interoperability limitations. Imaging staff operate scanners that produce proprietary image formats, which require uploads to closed vendor platforms for external access. These legacy systems are tightly bound to specific hardware and lack support for connecting devices from other manufacturers. 

Moreover, they do not provide open interfaces to automate or extend the second-opinion process, nor are they capable of managing the entire diagnostic workflow. Their limited flexibility and slow upload performance frequently lead to delays in collaboration. At the same time, medical specialists depend on immediate access to diagnostic-quality images, but current tools do not support seamless, cross-institutional access or flexible integration.

=== Inflexibility in Distributed and Remote Workflows
Even when data transmission and storage are technically feasible, current PACS platforms lack the flexibility required to support distributed workflows involving multiple stakeholders. Traditional PACS solutions are typically implemented as single-domain archive systems, offering limited support for modern usage paradigms such as regional collaboration, telemedicine, or shared infrastructures across organizational boundaries @lebre:2020:CloudReadyArchitectureShared. This structural rigidity becomes especially problematic in cross-institutional workflows where dynamic coordination between remote experts, imaging staff, and diagnostic systems is required.

An analysis of user discussions by Alhajeri et al. revealed further practical limitations in existing systems. Participants highlighted that many PACS deployments remain standalone, and that vendors often fail to supply the tools needed to support distributed workflows—such as integrated annotation capabilities or intelligent task distribution based on medical specialty and expert availability @alhajeri:2019:LimitationsSolutionsImproving. In particular, users of open-source PACS systems reported that available platforms do not always align with the operational needs of their institutions, underscoring a persistent mismatch between available functionality and workflow requirements in decentralized environments.

In Synlab’s case, these architectural limitations become evident in the handling of second-opinion workflows. The existing PACS infrastructure does not support key workflow-specific requirements such as intelligent task routing, role-based interaction, or status tracking. To compensate, Synlab relies on a separate application developed on Microsoft SharePoint to manually track the progress of each consultation. This parallel setup introduces additional administrative overhead, offers only limited interoperability with the PACS, and increases the likelihood of inconsistencies or human error throughout the diagnostic process.

== Motivation
#TODO[
  Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]
#GOAL[
  - Growing global demand for expert diagnostic collaboration.
  - Faster access = faster diagnosis = better patient outcomes.
  - Potential to disrupt current vendor-driven systems with interoperable architecture.
  - Enablement of distributed diagnosis workflows in a globalised and digitalized medical services landscape.
]
Remote medical consultations have become increasingly common, especially with the advancement of telemedicine @mohsin:2025:SystematicReviewRoles. In contrast, remote diagnostic collaboration—focused on doctor-to-doctor interaction—remains underrepresented in research, despite its potential to enhance access to expertise and continuity of care in distributed settings @baik:2024:DiversePerspectivesRemote. Despite this underrepresentation, there is substantial potential to be unlocked by developing an architecture that addresses the current limitations—particularly in handling large-scale medical imaging—to enable robust and efficient remote diagnostic workflows.

From a patient perspective, such advancements enable access to specialized diagnostics without the need to travel to urban medical centers, thereby making high-quality care available even in medically underserved regions @baik:2024:DiversePerspectivesRemote @mohsin:2025:SystematicReviewRoles. For medical service providers, the ability to collaborate with external experts allows local hospitals and laboratories to deliver advanced diagnostic services without maintaining in-house specialists @baik:2024:DiversePerspectivesRemote. This is particularly valuable when highly specific expertise—such as in rare tumor subtypes or complex pathology cases—is distributed across specialized institutions and not available at every site @zarella:2018:PracticalGuideWhole.

Vodovnik and Aghdam demonstrate that remote diagnostics can significantly enhance the efficiency of pathology services by reducing turnaround times, increasing diagnostic throughput, and supporting flexible and scalable workflows that improve resource allocation and resilience @vodovnik:2018:CompleteRoutineRemote. Moreover, for medical experts such as radiologists and pathologists, the shift toward digital and remote workflows opens the possibility of working from home, reducing commute time, increasing productivity, and potentially enhancing job satisfaction and work-life balance @recht:2023:WorkHomeAcademic.

Synlab and comparable healthcare providers operate in a rapidly evolving environment characterized by increasing competitive and financial pressures. In the hospital sector, Cutler and Morton document a clear trend toward consolidation into academic medical center “hubs,” surrounded by smaller, affiliated community hospitals. This structural change is largely driven by the financial challenges faced by independent institutions and the pursuit of improved service integration and efficiency @cutler:2013:HospitalsMarketShare. Similar dynamics affect laboratory service providers. High merger and acquisition activity forces organizations to consolidate operations, standardize processes, and leverage economies of scale.

Cook demonstrates how the University of Maryland Medical System pursued laboratory integration as a strategic response to these pressures, combining multiple laboratories across a regional system to improve cost-effectiveness, service quality, and access to advanced technologies, which smaller facilities could not afford independently @cook:2017:LaboratoryIntegrationConsolidation. Synlab’s operational model shows signs of a similar evolution, with specialized equipment and diagnostic expertise distributed across different geographic locations. However, to fully capitalize on this distributed infrastructure, robust technical capabilities for large-scale, remote medical imaging are essential.

Without an architecture that enables timely and secure transmission of high-resolution diagnostic images, the potential benefits of consolidation and specialization remain unrealized. Therefore, this thesis aims to design and test a scalable and interoperable system architecture that supports distributed diagnostic collaboration through efficient image sharing. The objective is to equip firms like Synlab with the technological foundation necessary to deliver high-quality diagnostics in a globally connected healthcare ecosystem.

== Objectives
#TODO[
  Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]
#GOAL[
  - Analyze Existing Technologies and Architectures.
  - Design a Scalable Architecture for Medical Imaging.
  - Implement a Prototype System.
  - Test the Architecture and Prototype.
]
This thesis aims to design, implement, and test a scalable and interoperable system architecture for medical imaging that enables efficient diagnostic collaboration in distributed healthcare environments. The goal is to address the technical challenges that prevent current systems from supporting cross-institutional workflows—especially in second-opinion scenarios involving large pathology image files.

The research begins with a concise analysis of current imaging technologies and architectures. It focuses on interoperability, vendor neutrality, and the ability to transfer large-scale imaging data efficiently. The analysis examines how current systems handle proprietary file formats and various scanner outputs, identifying limitations that hinder seamless integration. It also explores techniques for efficient image transfer for large-scale images like adaptive image delivery under heterogeneous network conditions, such as dynamic resolution streaming. These findings serve as the basis for designing a system architecture that supports efficient, interoperable diagnostic collaboration across institutional and technical boundaries.

Building on these insights, the thesis designs a scalable architecture that integrates secure file-sharing mechanisms with clinical systems such as PACS and LIS. The architecture supports heterogeneous file formats, dynamic resolution streaming, and distributed workflows in which high-end pathology scanners are located at centralized imaging centers while diagnostic experts access images remotely. A prototype is then implemented to demonstrate the feasibility of the architecture under realistic conditions in pathology image sharing, simulating a complete diagnostic workflow from image acquisition to remote access. It is designed to be modular and adaptable, serving as a technical proof of concept for the architecture.

Finally, the prototype is tested with respect to key performance indicators such as transfer speed, integration compatibility, and user experience. The test assesses the architecture's suitability for supporting distributed diagnostics and provides insights into its broader applicability for medical imaging workflows beyond pathology.

== Outline
#TODO[
  Describe the outline of your thesis
]
#GOAL[
  - Short overview of thesis chapters.
]
In Chapter 2, key background topics for this thesis are introduced, including
medical imaging ecosystems, standards, and interoperability issues. Then, related concepts and approaches are described to determine the current state of research, identify existing limitations in the field, and clarify the specific contribution of this work. Chapter 4 analyses the requirements of the system that is to be designed, following the structure outlined by Bruegge and Dutoit @bruegge:2010:ObjectorientedSoftwareEngineering, covering both functional and non-functional requirements. In Chapter 5 the architecture is developed, focusing on design goals, subsystem decomposition, and data management. In Chapter 6, the architecture is tested using the pathology use case at Synlab, with a focus on technical performance, integration capabilities and user feedback. Finally, Chapter 7 concludes the thesis by summarizing the project's status and discussing potential future work.