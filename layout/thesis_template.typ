#import "/layout/cover.typ": *
#import "/layout/titlepage.typ": *
#import "/layout/disclaimer.typ": *
#import "/layout/acknowledgement.typ": acknowledgement as acknowledgement_layout
#import "/layout/transparency_ai_tools.typ": transparency_ai_tools as transparency_ai_tools_layout
#import "/layout/abstract.typ": *
#import "/utils/print_page_break.typ": *
#import "/layout/fonts.typ": *

#let thesis(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  abstract_en: "",
  abstract_de: "",
  acknowledgement: "",
  transparency_ai_tools: "",
  is_print: false,
  body,
) = {
  cover(
    title: title,
    degree: degree,
    program: program,
    author: author,
  )

  pagebreak()

  titlepage(
    title: title,
    titleGerman: titleGerman,
    degree: degree,
    program: program,
    supervisor: supervisor,
    advisors: advisors,
    author: author,
    startDate: startDate,
    submissionDate: submissionDate
  )

  print_page_break(print: is_print, to: "even")

  disclaimer(
    title: title,
    degree: degree,
    author: author,
    submissionDate: submissionDate
  )
  transparency_ai_tools_layout(transparency_ai_tools)

  print_page_break(print: is_print)
  
  acknowledgement_layout(acknowledgement)

  print_page_break(print: is_print)

  abstract(lang: "en")[#abstract_en]
  abstract(lang: "de")[#abstract_de]

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en"
  )
  
  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fonts.body)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      link(
        el.location(),
        [Chapter #numbering(
          el.numbering,
          ..counter(heading).at(el.location())
        )]
      )
    } else {
      it
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "alphanumeric")

  // --- Figures ---
  show figure: set text(size: 0.85em)
  
  // --- Table of Contents ---
  show outline.entry.where(level: 1): it => {
    v(15pt, weak: true)
    strong(it)
  }
  outline(
    title: {
      text(font: fonts.body, 1.5em, weight: 700, "Contents")
      v(15mm)
    },
    indent: 2em
  )
  
  
  v(2.4fr)
  pagebreak()


    // Main body. Reset page numbering.
  set page(numbering: "1")
  counter(page).update(1)
  set par(justify: true, first-line-indent: 2em)

  body

  // Dictionary mapping labels to short captions
  let short-captions = (
    "MedicalImagingEcosystem": [Components of the medical imaging ecosystem (UML component diagram)],
    "MedicalImagingStandardsCommunication": [Communication between pathologist and medical imaging infrastructure (UML communication diagram)],
    "DicooglePathologyPACSArchitecture": [Vendor-neutral PACS architecture for pathology images as proposed by @marquesgodinho:2017:EfficientArchitectureSupport (UML component diagram)],
    "PathologyAIPlatform": [Digital pathology platform as proposed by @jesus:2023:PersonalizableAIPlatform (UML component diagram)],
    "RequirementsActivities": [Activities and resulting artifacts in the requirements engineering process (UML activity diagram)],
    "SynlabExistingSystem": [Architectual components of the existing system (UML component diagram)],
    "UseCaseDiagram": [Second Opinion Platform use cases (UML use case diagram)],
    "AOM": [Analysis Object Model of the Second Opinion Platform (UML class diagram)],
    "StateDiagram": [States of case (UML state diagram)],
    "UI-Dashboard": [Screenshot of the Seond Opinion Platform dashboard],
    "UI-Upload": [Screenshot of the upload form for a new case],
    "UI-CaseDetails": [Screenshot of the case details page],
    "SubsystemDecomposition": [Subsystem decomposition (UML component diagram)],
    "DeploymentDiagram": [Deployment diagram of the prototype system (UML deployment diagram],
  )

  // Customize outline entries to use short captions
  show outline.entry: it => {
    // Check if this entry is for a figure
    if it.element.func() == figure {
      let elem = it.element
      let label = elem.label
      
      // Get short caption if available
      let caption = if label != none {
        let label-str = str(label)
        // Check if key exists in dictionary keys
        if label-str in short-captions.keys() {
          short-captions.at(label-str)
        } else {
          elem.caption
        }
      } else {
        elem.caption
      }

      // Replace the content while keeping the structure
      link(
      elem.location(),
      it.indented([*#it.prefix()*], [*#caption #box(width: 1fr, it.fill) #it.page()*])
      )
    }
  }

  // List of figures
  pagebreak()
  heading(numbering: none)[List of Figures]
  outline(
    title: "",
    target: figure.where(kind: image),
  )

  // Appendix.
  pagebreak()
  include("/layout/appendix.typ")

  pagebreak()
  bibliography("/thesis.bib")
}
