#import "/utils/todo.typ": TODO

= Problem <Problem>
Current clinical imaging infrastructures remain fragmented, vendor-bound, and technically inflexible—creating significant barriers in critical diagnostic workflows. One common scenario for Synlab is the Second Opinion workflow in digital pathology, which sequence diagram is illustrated in @medicalImagingProcess. The attending physician initiates a clarification request for an anomaly, but the infrastructure delays the response.

#figure(
  image("../../figures/medical-imaging-process.png", width: 90%),
  caption: [Exemplary medical imaging sequence diagram for the process performed by Synlab to gather Second Opinions on pathology images.],
) <medicalImagingProcess>

Image creators work with proprietary scanners that produce high-resolution files, often exceeding multiple GB, and must transfer these files via closed, vendor-specific platforms @TorabMiandoab.2023. These uploads are slow and frequently take several hours, leading to delayed availability of critical diagnostic images. This delay reduces the attending physician’s ability to consult external medical specialists promptly, postponing treatment decisions.

The medical specialist requires immediate access to high-quality diagnostic images to provide a Second Opinion. The slow transfer times and incompatibility between different systems force specialists to wait for images, leading to inefficient collaboration and frustration. This negatively impacts diagnostic accuracy and decision-making speed. Patients experience delayed diagnoses and treatments, especially when rapid intervention is crucial.

The inability of today’s systems to handle large-scale imaging across heterogeneous platforms limits the potential of distributed diagnostic networks. Existing software does not sufficiently support the business requirements emerging from laboratory consolidation and medical service specialization. The result is operational inefficiency, reduced diagnostic quality, and a diminished capacity to benefit from global medical expertise.