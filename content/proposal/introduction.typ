#import "/utils/todo.typ": TODO


= Introduction
Medical imaging plays a central role in modern diagnostics and treatment planning across many clinical domains. Advances in digital imaging allow clinicians to capture high-resolution scans, improving the accuracy and efficiency of medical assessments—especially in fields like radiology and pathology, where visual data is critical for identifying anomalies and guiding decisions.

Jodogne describes a range of specialized tools and systems that operate in concert to support diagnostic workflows @Jodogne.2018. @HighLevelEcosystem illustrates high-resolution imaging scanners that produce detailed visual representations of tissue samples, anatomical structures, or physiological processes. Manufacturers typically couple these scanners with proprietary software that handles image acquisition, visualization, and initial data processing.

Clinicians use medical information systems to integrate imaging data into the clinical environment by linking scans with patient records and diagnostic workflows. Healthcare organizations use Picture Archiving and Communication Systems (PACS) for long-term storage, retrieval, and access to imaging data, and Laboratory Information Systems (LIS) to manage complementary laboratory information such as test orders, results, and associated metadata @HUANG19931. Together, these systems support diagnostic collaboration while presenting new challenges and opportunities as healthcare digitalization evolves.

#figure(
  image("../../figures/high-level-ecosystem.png", width: 80%),
  caption: [High-level medical imaging ecosystem.],
  
) <HighLevelEcosystem>