#import "/utils/todo.typ": TODO
#import "/utils/goal.typ": GOAL

= Summary
#TODO[
  This chapter includes the status of your thesis, a conclusion and an outlook about future work.
]

== Status
#TODO[
  Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
]

=== Realized Goals
#TODO[
  Summarize the achieved goals by repeating the realized requirements or use cases stating how you realized them.
]
#GOAL[
  - Goals to be expected
    - Successful implementation of a prototype system for sharing large pathology scans
    - Achieved integration with Synlab’s PACS/LIS (e.g. using DICOMweb)
    - Fulfilled performance requirement: Transfer times for x GB scans under x minutes in test scenarios
    - Positive feedback on usability from clinical stakeholders
    - Demonstrated general architecture feasibility through pathology use case
    - (if implemented) Implemented secure data handling (encryption at rest and in transit)
]

=== Open Goals
#TODO[
  Summarize the open goals by repeating the open requirements or use cases and explaining why you were not able to achieve them. Important: It might be suspicious, if you do not have open goals. This usually indicates that you did not thoroughly analyze your problems.
]
#GOAL[
  - Expected open goals
    - Full real-time collaboration features (multi-user simultaneous interaction)
    - Automated proprietary format conversion for all formats was not realized (requires more extensive vendor cooperation and research)
    - Limited evaluation generalizability as prototype was only tested within Synlab pathology environment
    - Usability testing with larger and more diverse user groups / more scanners remains open
]

== Conclusion
#TODO[
  Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
]
#GOAL[
  - Recap of the addressed problem: inefficient and vendor-locked sharing of large pathology scans for second-opinion workflows
  - Summarized solution: vendor-neutral, scalable cloud architecture integrated with DICOMweb and PACS/LIS
  - Contributions:
    - Developed and tested a modular prototype system
    - Provided empirical evidence of performance and usability improvements
    - Delivered a generalizable architectural framework applicable beyond pathology
]


== Future Work
#TODO[
  Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
]
#GOAL[
  - Potential future work points
    - Broaden evaluation to other medical domains (e.g. radiology, cardiology) to test generalizability of the architecture
    - Implement advanced real-time collaboration features (simultaneous viewing, annotations)
    - Develop automated and intelligent image format conversion pipelines
    - Enhance security with advanced features such as anomaly detection (AI) and zero-trust architecture principles
    - Integrate with AI-powered diagnostic tools for augmented expert collaboration
    - Implement advanced security measurements and user authentication / permission / roles
    - Conduct larger scale usability studies across different user groups and institutions
]