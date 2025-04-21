#import "/utils/todo.typ": TODO


= Introduction
Medical imaging plays a central role in modern diagnostics and treatment planning across a wide range of clinical domains. In recent years, advancements in digital imaging technologies have enabled the capture of high-resolution scans that support more accurate and efficient medical assessments. These technologies are particularly prominent in areas such as radiology and pathology, where visual data is essential for identifying anomalies, classifying diseases, and guiding clinical decisions.

Within the medical imaging ecosystem, a range of specialized tools and systems operate in concert to support diagnostic workflows. As illustrated in @HighLevelEcosystem, high-resolution imaging scanners produce detailed visual representations of tissue samples, anatomical structures, or physiological processes. These scanners are typically coupled with proprietary software that handles image acquisition, visualization, and initial data processing. To integrate imaging data into the clinical environment, medical information systems play a vital role in linking scans with patient records and broader diagnostic workflows. Picture Archiving and Communication Systems (PACS) are responsible for the long-term storage, retrieval, and access to imaging data, while Laboratory Information Systems (LIS) manage complementary laboratory information such as test orders, results, and associated metadata @HUANG19931.

#figure(
  image("../../figures/high-level-ecosystem.png"),
  caption: [High-level medical imaging ecosystem.],
) <HighLevelEcosystem>

This technical ecosystem forms the basis for numerous diagnostic and collaborative processes, offering both opportunities and challenges as digitalization in healthcare continues to advance.