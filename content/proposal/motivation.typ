#import "/utils/todo.typ": TODO


= Motivation
Global diagnostic collaboration demands an architecture capable of supporting distributed, vendor-neutral workflows. As laboratories specialize and services decentralize, fast and secure sharing of large-scale imaging data becomes critical for effective clinical decision-making.

Imaging personnel benefit from standardized systems that reduce reliance on proprietary tools and streamline acquisition processes. Medical experts have immediate access to diagnostic scans—regardless of location—to collaborate efficiently and deliver timely insights. Patients, in turn, experience faster diagnoses and treatments, improving outcomes in time-sensitive cases.

Prior research has established strong foundations. Lebre et al. introduced a vendor-neutral repository architecture @Lebre.2020, while Ghasemifard and Liu et al. built scalable SaaS platforms for medical imaging @Ghasemifard.2014 @Liu.2016. Ukis et al. proposed a web-based viewer for simplified access @6684428, and the iMAGE cloud architecture in @ImageCloudArchitecture showcases how cloud infrastructures can enhance regional healthcare imaging services.

#figure(
  image("../../figures/iMAGE-cloud-architecture.png", width: 100%),
  caption: [Exemplary cloud infrastructure for regional healthcare imaging services @Liu.2016.]
) <ImageCloudArchitecture>

Yet, these architectures focus mainly on processing and visualization—not on supporting end-to-end diagnostic workflows like second-opinion cases. To bridge this gap, a new architecture must be developed—one that enables real-time, interoperable, and scalable collaboration across institutions. This thesis takes up that challenge, extending prior concepts into a fully functional framework for distributed medical diagnostics.
