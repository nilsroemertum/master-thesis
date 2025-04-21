#import "/utils/todo.typ": TODO

= Problem
High-resolution medical imaging introduces scientific and technical challenges, particularly around the handling of large, proprietary data formats under strict security and compliance requirements. A typical example is the second-opinion workflow, as illustrated in @medicalImagingProcess. In this process, an attending physician requests a diagnostic clarification—such as a suspected anomaly in a pathology scan. An image is then created by a technician (image creator), which must be shared with an external medical specialist for a second opinion. The result of this assessment influences the final diagnosis and treatment decision. Despite its clinical importance, this process often encounters significant limitations due to inflexible and fragmented technical infrastructure.

#figure(
  image("../../figures/medical-imaging-process.png"),
  caption: [Examplary medical imaging process.],
) <medicalImagingProcess>

*Imaging Personnel Challenges:*
Technicians and scanner operators work with advanced imaging devices that produce large-scale image data. These are typically stored in proprietary formats and require upload to closed vendor platforms leading to lack of interoperability to other systems. This leads to long processing times, software compatibility issues, and an inability to quickly respond to diagnostic needs. @TorabMiandoab.2023

*Medical Experts and Analysts Challenges:*
Pathology experts and diagnostic professionals depend on timely, high-quality access to imaging data. However, interoperability gaps and restricted platform access delay evaluations and limit collaborative diagnostics. The reliance on vendor-specific viewers or tools restricts the freedom to use more effective or integrated workflows.

*Patients-Centric Challenges:*
The downstream impact affects patients directly. Extended waiting times for second opinions or definitive diagnoses create stress, delay treatment, and in critical cases may impact medical outcomes. Fast and flexible data access is therefore not just a technical necessity but a clinical imperative.

In summary, the combination of closed ecosystems, complex data formats, and slow transfer channels creates critical bottlenecks for all stakeholders. This illustrates the urgent need for platform-independent, scalable, and secure architectures that enhance medical imaging workflows and support timely decision-making.