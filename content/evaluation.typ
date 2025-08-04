#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Testing
#TODO[
  If you did an evaluation / case study, describe it here.
]

== Design 
#TODO[
  Describe the design / methodology of the evaluation and why you did it like that. e.g. what kind of evaluation have you done (e.g. questionnaire, personal interviews, simulation, quantitative analysis of metrics), what kind of participants, what kind of questions, what was the procedure?
]
#GOAL[
  - Technical validation
    - Performance tests measuring transfer times (quantitative metrics).
    - Integration tests with Synlab’s existing PACS/LIS systems.
    - Monitoring system reliability under realistic operational conditions.
  - Usability assessment
    - Structured interviews/questionnaires with users (clinicians and imaging technicians at Synlab).
    - Participants selected based on their regular involvement with digital pathology workflows.
    - Questions targeting ease-of-use, perceived efficiency, workflow integration, satisfaction.
  - Evaluation procedure
    - Clearly defined scenario execution (second opinion workflow simulations).
    - Systematic data collection (logs, response times, transfer times).
    - Conduct structured feedback sessions/interviews post-testing.
]

== Objectives
#TODO[
  Derive concrete objectives / hypotheses for this evaluation from the general ones in the introduction.
]
#GOAL[
  - EO1 Performance Objective: Verify the prototype consistently transfers pathology scans under x minutes (for 20–30 GB).
  - EO2 Interoperability Objective: Confirm seamless integration with Synlab’s clinical PACS/LIS systems via DICOM/DICOMweb.
  - EO3 Usability Objective: Assess and validate positive user experience, minimal training effort, and overall acceptance by clinicians and technicians.
  - EO4 Reliability Objective: Ensure robustness of the system under realistic operational conditions (multiple concurrent users, interruptions).
]

== Results
#TODO[
  Summarize the most interesting results of your evaluation (without interpretation). Additional results can be put into the appendix.
]
#GOAL[
  - Technical Performance (average/maximum file transfer times, availaility, reliability e.g. number of sucessful transfers)
  - Interoperability Results (Integration success rate with PACS/LIS if not mocked, number and nature of interoperability issues encountered)
  - Usability Feedback (quantitative/qualitative)
    - Summarized user satisfaction ratings (e.g. Likert scale)
    - Highlight key responses from user questionnaires/interviews
    - Present quantitative results clearly in tables or graphs (details like questionnaires may be attached in appendix)
]

== Findings
#TODO[
  Interpret the results and conclude interesting findings
]
#GOAL[
  - Technical Performance Findings
    - Achievement of transfer speed objective (x min per 20-30 GB scan)
    - Key factors influencing performance (network, encryption overhead, concurrent usage)
  - Interoperability Findings
    - Overall compatibility and success in integration with PACS/LIS
    - Recurring technical interoperability challenges (e.g., metadata handling, DICOM compatibility)
  - Usability Findings
    - Level of user acceptance and ease of adoption
    - Specific UI/UX elements identified as strong or weak by users
  - Reliability Findings
    - Observed robustness and stability of the prototype system
    - Specific points of failure or reliability concerns identified
]

== Discussion
#TODO[
  Discuss the findings in more detail and also review possible disadvantages that you found
]
#GOAL[ //TODO check
  - Performance Discussion
    - Suitability of achieved performance for realistic pathology workflows
    - Detailed analysis of trade-offs encountered (performance vs. security, complexity vs. usability)
  - Interoperability and Clinical Integration Discussion
    - Clinical implications of observed integration issues and successes
    - Potential impacts on real-world diagnostic workflows (efficiency, disruptions)
  - Usability Discussion
    - In-depth consideration of usability issues and recommendations derived from user feedback
    - Implications for future development and deployment
  - Generalizability Discussion
    - Applicability of the architecture beyond pathology (radiology, cardiology, oncology)
    - Clearly articulate adaptable versus pathology-specific architecture elements
    - Challenges and constraints if generalized to other medical imaging domains
]

== Limitations
#TODO[
  Describe limitations and threats to validity of your evaluation, e.g. reliability, generalizability, selection bias, researcher bias
]
#GOAL[
  - Reliability of Results
    - Variability risks in technical metrics (network conditions, infrastructure variability)
  - Generalizability of Findings
    - Limitations due to case study being restricted to pathology at Synlab
    - Selection bias from single-institution testing
  - User Feedback Limitations
    - Risks associated with small participant group and possible bias in user selection
    - Subjectivity in user responses and potential biases from evaluation settings
  - Researcher Bias
    - Potential influence of researcher involvement in system development and evaluation
    - Measures taken to mitigate researcher influence
  - Data and Measurement Limitations
    - Constraints from simulated scenarios versus real operational scenarios
    - Constraints from only testing with limited test scans
]