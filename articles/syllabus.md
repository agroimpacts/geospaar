# Geography 246/346 Syllabus

## Overview

Originally developed for statistics, free and open source R became one
of the most widely used research/analytical programming languages in
both industry and academia. Among its many applications, `R`’s
capabilities for geospatial analyses have received significant develop
attention, as evidenced the large (and still growing) ecosystem of `R`
spatial libraries (covering everything from basic vector and raster
manipulation to advanced modeling and image processing), its classes for
representing spatial data, and expanding capacity to interact with and
leverage the capabilities of other geospatial libraries (GDAL, duckDB),
desktop (e.g. GRASS, QGIS, PostGIS, SAGA), and web-based platform
(e.g. Google Earth Engine). Alongside its geospatial capabilities, there
has been concurrent development of interactive development environments
(IDEs) for `R`, which facilitate the creation, presentation, and
reproducibility of analyses. `R` is also particularly good for rapid,
interactive analyses. `R` therefore is pretty close to being a one-stop
shop for GIScience work. This course will provide students with the
skills they need to use `R` as a GIS. There will be additional emphases
on programming, presentation, and reproducibility, which will entail
learning to develop `R` libraries, development of presentations and
reports using Rmarkdown (or quarto), and using version control with
github. Students will learn and apply `R` skills by working on a
specific research problem.

### Meeting Time/Place

B124, MW 1615-1730

### Office Hours

| Instructor    | Office         | Office hours      |
|---------------|----------------|-------------------|
| Lyndon Estes  | Jefferson 201C | Tuesday 1300-1500 |
| Luis Oliveira | Geography M103 | TBD               |

### Philosophy

Although our primary focus is learning how to use `R` for geospatial
analysis, the course also introduces additional skills and concepts
related to ***reproducible*** research, and covers how and why `R`
capabilities can and should be fit into analytical workflows that are
increasingly driven by AI.

### Caveats/things to consider

Here are some other aspects regarding this course that you may wish to
consider before committing:

1.  ***Assignments in this class are problem-oriented, not
    recipe-based***:

    The best way to learn R (and any human or computational language,
    for that matter) is to figure out how to use it to solve specific
    problems. There are usually multiple paths that can be taken to
    solve a problem, particularly in `R`, which has a huge number of
    contributors and over 10,000 packages. Coding recipes that spell out
    precise steps needed to arrive at a solution will not take you as
    far towards `R` fluency, and will prevent you from learning the
    diversity of this language. Similarly, if you simply prompt an AI
    tool for code, you won’t learn much. Furthermore, tt can be very
    rewarding to figure out programming problems (I personally prefer
    programming to writing papers), even if it is often frustrating.

2.  ***The order in which material is introduced will occasionally be
    non-linear***:

    Primarily because we are introducing reproducibility concepts up
    front in this class, which entails learning about some things that
    people might ordinarily get around to after they know a bit of `R`
    code. However, this order of things may enable you to learn `R` (or
    any other programming language) more rapidly. It might even make it
    more fun.

3.  ***This is a flipped class***:

    Materials and problems are expected to be done before class. There
    will be some lecturing on key concepts, but class is intended to
    function more like a lab (and the lab period is intended for
    students seeking extra help), in which you work through practical
    problems, clarify concepts that are unclear, or present your work to
    your peers.

### Required Texts, Reading, Exam, and Assignments

There is no required textbook for this course. There is a huge amount of
well-developed `R` material that is freely available on the web. We draw
on and those resources for this class and integrate them into our own
content (citing/linking to show where they come from).

**Readings and assignments** should be completed ***before*** the class
they are listed under. This is key to learning the language, ***as it is
difficult to learn programming by just listening to lectures.***

***Practical assignments***. During the first two units, there will be a
total of 5 assignments (see links within the individual modules), *each
of which will include an in-class written component*. The sixth
assignment is your project overview. The week assignments are due is
listed on the syllabus, to be submitted by midnight on the Friday of
that week. With the exception of the in-class written component, you
will undertake and submit your work through github repositories that
exist under the Agricultural Impacts Research Group’s github
[organization](https://github.com/agroimpacts), where there is a
[team](https://github.com/orgs/agroimpacts/teams/geog246346) setup for
this class. You will need to join [GitHub](http://github.com) (it’s
free!) to be able to submit assignments, as we will need your github
name to add you to the team. You will manage your individual assignments
under private personal repositories that will be listed under your own
individual sub-team.

***Exam***. At the end of the first two units, we will also give an
in-class coding exam that covers some of the key programming and
reproducibility concepts covered.

**Projects** Each student will be required to undertake a final project.
Please see the
[projects](https://agroimpacts.github.io/geospaar/articles/projects.md)
page for more detail.

### Style

There are many ways to write code and get the results you want. However,
not all ways of writing code are equal. Some code is messy and hard to
read. Other code is organized, clean, and easy to read. The latter is
what we are aiming for, as it helps to foster reproducibility. In this
class, we will follow [Hadley Wickham’s style
guide](http://adv-r.had.co.nz/Style.md). Please study it.

[Back to top](#top)

### Assessment and engaged time

Your progress in this class will be assessed as follows:

| Component                           | GEOG246      | GEOG346      |
|:------------------------------------|:-------------|:-------------|
| Practical assignments (n=5)         | 40% of grade | 30% of grade |
| Exam                                | 15% of grade | 15% of grade |
| Participation                       | 15% of grade | 15% of grade |
| Overview for final semester project | 5% of grade  | 10% of grade |
| Final report on semester project    | 25% of grade | 30% of grade |

Grading will be based on the rubrics found under the
[Assessment](https://agroimpacts.github.io/geospaar/articles/assessment.md)
vignette.

Courses at Clark are worth 4 credit hours, which equates to 180 hours of
engaged academic time. The breakdown of that time is estimated to be:

|                                | GEOG246 hours | GEOG346 hours |
|:-------------------------------|--------------:|--------------:|
| Class meetings/exam            |            37 |            37 |
| Readings                       |            12 |            14 |
| Practicals                     |            40 |            50 |
| Semester projects-analysis     |            65 |            59 |
| Semester projects-presentation |            10 |             8 |
| Semester projects-final report |            16 |            12 |
| Total hours                    |           180 |           180 |

### Expectations

Since class is flipped, this is a time for questions and discussion,
between us and you, and often between yourselves. However, please keep
any conversations low and necessary to the task at hand if they are
one-on-one.

Class attendance is expected. It is the primary time in which to get
help on understanding reading materials and assignments (see next
section on Communications). Late assignments (including presentations
and final report) are not accepted, barring any emergency or reasonable
conflicts that prevent on-time submissions.

For assignments in the first two units, students can work together to
figure out coding problems and to understand the material, but final
assignments should reflect each student’s own work and coding effort
(i.e. not copying code from someone else). For final projects, many, if
not most, of the projects will be team-based (2-3 per team, depending on
the nature of the assignment) on some if not all of the available
topics.

We will follow the University’s policies on plagiarism and cheating.
Please familiarize yourself with the University’s
[policy](http://www2.clarku.edu/offices/aac/integrity.cfm) on academic
integrity, particularly section I.

#### Policy on use of artificial intelligence

You are allowed to use AI in this class, with the acceptable use falling
somewhere between Clark’s [limited and extensive use
designations](https://www.clarku.edu/ai/teach/). What does that mean in
practice? You are allowed to use AI to ask questions to help solve
coding problems, give guidance on package structure, solving `git`
issues, etc. You should not feed the assignment prompt or parts of the
prompt directly into an AI and just takes its answer, as you won’t learn
much (except that agents can give really good answers). Having said
this, we are not going to be looking over your shoulder as you work, so
in your assignments you should document how you used AI (e.g. through
links to chats), and you will be asked to answer several questions about
each assignment in (hand)writing. For your final project work, more
extensive AI use will be permitted, which you should also document.

#### Communications

We will conduct class communications via a Slack channel that you should
already be invited to. ***Please don’t send emails as they will go
unanswered***. Class-wide discussions will be conducted in the
\#fall2021 channel. Individual and restricted group messaging will be
conducted via Slack direct messaging, e.g. grade reporting, confidential
questions.

### Title IX

Clark University and its faculty are committed to creating a safe and
open learning environment for all students. Clark University encourages
all members of the community to seek support and report incidents of
sexual harassment to the Title IX office (<titleix@clarku.edu>). If you
or someone you know has experienced any sexual harassment, including
sexual assault, dating or domestic violence, or stalking, help and
support is available.

Please be aware that all Clark University faculty and teaching
assistants are considered responsible employees, which means that if you
tell me about a situation involving the aforementioned offenses, I must
share that information with the Title IX Coordinator, Brittany Rende
(<titleix@clarku.edu>). Although I have to make that notification, you
will, for the most part, control how your case will be handled,
including whether or not you wish to pursue a formal complaint. Our goal
is to make sure you are aware of the range of options available to you
and have access to the resources you need.

If you wish to speak to a confidential resource who does not have this
reporting responsibility, you can contact Clark’s Center for Counseling
and Professional Growth (508-793-7678), Clark’s Health Center
(508-793-7467), or confidential resource providers on campus:
Prof. Stewart (<als.confidential@clarku.edu>), Prof. Palm Reed
(<kpr.confidential@clarku.edu>), and Prof. Cordova
(<jvc.confidential@clarku.edu>).

### Career readiness

The skills you will develop through this course are important to future
employers. While you may find opportunities during the semester to grow
in all eight Career Competencies, the learning goals of this course most
closely relate to
[competencies](https://www.clarku.edu/curriculum-and-careers/career-readiness-competencies/)
in Critical Thinking, Professionalism, Teamwork, Technology, and
(Quantitative) Communication.

## Course Structure

The following is an overview of the course structure, broken down by
Unit, with a listing of the material to be covered each week, including
the week in which unit assignments are due (assignments are due by
midnight on Friday during the indicated week).

### Unit 1. An introduction to R and related reproducibility skills

In this first part of the course, we will learn the basics of working
with `R`, starting with non-spatial data. We will also learn some
additional skills that foster ***reproducibility***, which can be
loosely defined as the ability for you and others to *easily* repeat the
steps of your analysis, including the use of `git` and
[github](https://github.com), how to create an R package, and the use of
`Rmarkdown` to document and present your analyses.

The detailed readings and assignments for each week and day can be found
in the accompanying [Unit 1
vignette](https://agroimpacts.github.io/geospaar/articles/unit1.md), as
well as the overall learning goals for the unit.

#### Week 1. Introduction/Overview of R and Reproducibility

#### Week 2. Reproducibility Continued

- Module 1 assignment (#1) due

#### Week 3. R fundamentals and Skills

#### Week 4. R fundamentals and Skills

- Module 2/3 assignment (#2) due

#### Week 5. Data preparation and visualization / Basic analytics

#### Week 6. Data preparation and visualization / Basic analytics

- Unit 1 Module 4 assignment (#3) due

### Unit 2. Handling and analyzing spatial data with R

In this part of the course we will start to learn to use R as a GIS. The
detailed syllabus can be found in the [Unit 2
vignette](https://agroimpacts.github.io/geospaar/articles/unit2.md).

#### Week 7. Introduction, working with vector data

#### Week 8. Vectors continued

- Unit 2 Module 1 assignment (#4) due

#### Week 9. - Working with raster data

#### Week 10-11. - Raster data continued

- Unit 2 Module 2 assignment (#5) due
- Exam

### Unit 3. Projects

#### Week 12 - Project selection

- Final project overview due

#### Weeks 13-15 - Project work

Students will spend this time working on their projects, with a
particular focus on working with us to identify and trouble-shoot
methods.

The class periods in this week can be used for continued project work.
**The final project will be submitted during the exam week.**

## Resources

The following are some links to primary resources that you may wish to
consult as an alternative to direct LLM prompting.

### Books etc

- [The R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf)
- [Efficient R
  Programming](https://csgillespie.github.io/efficientR/index.html#building-the-book)
- [Swirl Stats](http://swirlstats.com) and the `swirl` package

### The intertubes

#### R general

- [CRAN](https://cran.r-project.org), particularly an [Introduction to
  R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html) the
  Task view [Analysis of Spatial
  Data](https://cran.r-project.org/web/views/Spatial.html)
- [R Exercises](http://www.r-exercises.com)
- [ROpenSci](https://ropensci.org)
- [Kelly Black’s R tutorial](http://www.cyclismo.org/tutorial/R/#)
- [Creating reproducible
  examples](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example)
  (read this before posting to one of the mailing lists)
- [R mailing lists/listservs](https://www.r-project.org/mail.html)
- [Speeding up R](http://www.noamross.net/blog/2013/4/25/faster-talk.md)
- [tidyverse tutorial
  video](https://www.youtube.com/watch?v=9q7gssUP8UA)

#### Advanced analytics

- [Generalized Additive
  Models](http://multithreaded.stitchfix.com/blog/2015/07/30/gam/)
- [Regression Trees, Random Forests, Gradient
  Boosting](https://www.analyticsvidhya.com/blog/2016/04/complete-tutorial-tree-based-modeling-scratch-in-python/)
- [Support Vector
  Machines](https://eight2late.wordpress.com/2017/02/07/a-gentle-introduction-to-support-vector-machines-using-r/)
- [Change point
  detection](https://www.r-bloggers.com/change-point-detection-in-time-series-with-r-and-tableau/)
- [Deep learning in R,
  1](https://blog.rstudio.com/2018/02/06/tensorflow-for-r/)
- [Deep learning in R,
  2](https://datascienceplus.com/deep-learning-with-r/)
- [R and DuckDB](https://borkar.substack.com/p/r-workflows-with-duckdb)

#### Reproducibility

- [Add citations to an Rmarkdown
  document](https://www.rdocumentation.org/packages/citr/versions/0.2.0)
- [Rmarkdown
  cheatsheet](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)
- [Tools for Reproducible Research](http://kbroman.org/Tools4RR/)
- [manuscriptPackage](https://github.com/jhollist/manuscriptPackage): An
  R package that provides a package template for ***writing a Latex
  manuscript using Rmarkdown***, complete with citations.

#### R versus python

This is a big topic, and python is but here are a few links to get
started. Lately the two seem to be converging in terms of usage
(i.e. there is a trend towards using both together, or completely
relying on python, as it anecdotally tends to be selected preferentially
in AI-based coding solutions), more read the latest news from
Rstudio–see the first link)

- [*Posit – Why RStudio Is Changing Its
  Name*](https://appsilon.com/posit-rstudio-rebrands/)
- [*R Vs Python: What’s the
  Difference?*](https://www.guru99.com/r-vs-python.html)
- [*R vs. Python: Which is a better programming language for data
  science?*](https://www.techrepublic.com/article/r-vs-python-which-is-a-better-programming-language-for-data-science/)
- [*Why I’ll stick with
  R*](https://md.ekstrandom.net/blog/2016/04/using-r/)
- [Why not
  both?](https://www.r-bloggers.com/the-best-of-both-worlds-r-meets-python-via-reticulate/)

#### R spatial

- [A short R spatial
  tutorial](https://pakillo.github.io/R-GIS-tutorial/), with some good
  examples for connecting to Google Maps.
- [Another R spatial
  tutorial](https://cran.r-project.org/doc/contrib/intro-spatial-rl.pdf),
  with `ggplot2` and `tmap`

#### Blogs/twitter to follow

- [R-Ladies](https://rladies.org/)
- [R-bloggers](https://www.r-bloggers.com/)
- [R-spatial](http://r-spatial.org/)
- [@RLangTip](https://twitter.com/RLangTip)

------------------------------------------------------------------------

[Back to home](https://agroimpacts.github.io/geospaar/articles/index.md)

------------------------------------------------------------------------
