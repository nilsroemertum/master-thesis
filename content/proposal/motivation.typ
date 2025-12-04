#import "/utils/todo.typ": TODO


= Motivation
Global diagnostic collaboration demands an architecture capable of supporting distributed, vendor-neutral workflows. As laboratories specialize and services decentralize, fast and secure sharing of large-scale imaging data becomes critical for effective clinical decision-making. Imaging personnel benefit from standardized systems that reduce reliance on proprietary tools and streamline acquisition processes. Medical experts have immediate access to diagnostic scans—regardless of location—to collaborate efficiently and deliver timely insights. Patients, in turn, experience faster diagnoses and treatments, improving outcomes in time-sensitive cases.

Researchers have established strong foundations in prior research. Lebre et al. introduced a vendor-neutral repository architecture @Lebre.2020, while Ghasemifard and Liu et al. built scalable SaaS platforms for medical imaging @Ghasemifard.2014 @Liu.2016. @ImageCloudArchitecture illustrates the iMAGE cloud architecture, which showcases how cloud infrastructures can enhance regional healthcare imaging services. Ukis et al. proposed a web-based viewer for simplified access @6684428.

#figure(
  image("../../figures/uml/iMAGE-cloud-architecture.png", width: 90%),
  caption: [Cloud-based healthcare imaging infrastructure adapted from @Liu.2016. The architecture integrates medical image acquisition, storage, and processing services in a hybrid cloud environment, offering enhanced scalability and access across healthcare institutions.]
) <ImageCloudArchitecture>

Yet, these architectures focus mainly on processing and visualization—not on supporting end-to-end diagnostic workflows like Second Opinion cases. This gap requires the development of a new architecture that enables real-time, interoperable, and scalable collaboration across institutions. This thesis takes up that challenge, extending prior concepts into a fully functional framework for distributed medical diagnostics.
