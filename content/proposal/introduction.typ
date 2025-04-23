#import "/utils/todo.typ": TODO


= Introduction
Medical imaging plays a central role in modern diagnostics and treatment planning across many clinical domains. Advances in digital imaging have enabled the capture of high-resolution scans, improving the accuracy and efficiency of medical assessments—especially in fields like radiology and pathology, where visual data is critical for identifying anomalies and guiding decisions.

Within the medical imaging ecosystem, a range of specialized tools and systems operate in concert to support diagnostic workflows. @Jodogne.2018 illustrated in @HighLevelEcosystem, high-resolution imaging scanners produce detailed visual representations of tissue samples, anatomical structures, or physiological processes. These scanners are typically coupled with proprietary software that handles image acquisition, visualization, and initial data processing. To integrate imaging data into the clinical environment, medical information systems play a vital role in linking scans with patient records and broader diagnostic workflows. Picture Archiving and Communication Systems (PACS) are responsible for the long-term storage, retrieval, and access to imaging data, while Laboratory Information Systems (LIS) manage complementary laboratory information such as test orders, results, and associated metadata @HUANG19931.

#figure(
  image("../../figures/high-level-ecosystem.png", width: 80%),
  caption: [High-level medical imaging ecosystem.],
  
) <HighLevelEcosystem>

Together, these systems support diagnostic collaboration while presenting new challenges and opportunities as healthcare digitalization evolves.