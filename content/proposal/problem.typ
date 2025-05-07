#import "/utils/todo.typ": TODO

= Problem
Large-scale medical imaging increasingly supports diagnostic collaboration across institutions and borders. As laboratory networks evolve and specialized medical services become globally distributed, the demand for fast, secure, and interoperable image sharing grows rapidly. However, current imaging infrastructures remain fragmented, vendor-bound, and technically inflexible—creating significant barriers in critical diagnostic workflows.

One common scenario is the second-opinion workflow in digital pathology, as illustrated in @medicalImagingProcess. In this workflow, a clinician seeks a diagnostic consultation from an external expert, often located in a different institution or country. A technician captures high-resolution pathology scans, sometimes exceeding 20–30 GB in size, which then need to be transferred for expert review. Delays in this process can postpone diagnosis and treatment decisions. Laboratory service providers such as Synlab use this workflow to enable global collaboration among pathologists—highlighting the need for robust, cross-institutional data sharing solutions.

#figure(
  image("../../figures/medical-imaging-process.png", width: 80%),
  caption: [Exemplary medical imaging process.],
) <medicalImagingProcess>

Despite its clinical relevance, this workflow exposes multiple problems. Imaging staff work with scanners that produce proprietary image formats, requiring uploads to closed vendor platforms. These transfers are slow and regularly take hours, delaying collaboration. Medical specialists depend on immediate access to diagnostic-quality images, but current tools lack interoperability and flexibility, preventing seamless expert involvement @TorabMiandoab.2023. Patients ultimately experience delayed diagnoses and treatments—an especially serious issue when rapid intervention is needed.

The inability of today’s systems to handle large-scale imaging across heterogeneous platforms limits the potential of distributed diagnostic networks. Existing software does not sufficiently support the business requirements emerging from laboratory consolidation and medical service specialization. The result is operational inefficiency, reduced diagnostic quality, and a diminished capacity to benefit from global medical expertise.