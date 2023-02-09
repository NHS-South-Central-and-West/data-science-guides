# Data Science Guides

A repository containing worked examples in R & (eventually) Python of some common data science tasks, to use as a space for learning how to implement these methods, and as a template for applying data science to SCW work.

## Usage

### R/Python

In order to implement the guides in this repository, you will need to install R and/or Python (depending on which you wish to use). Getting R and Python installed on your local machine can prove to be a non-trivial task, and knowing which tools are best for using either language (especially Python) can sometimes act as a bit of a barrier for new users.

To help reduce the barriers to entry for new users, there is a [notebook](https://htmlpreview.github.io/?https://github.com/NHS-South-Central-and-West/data-science-guides/blob/main/guides/getting-started.html) that takes you through some of these challenges, from getting either language installed on your local machine to which tools to use.

### Git

If you are new to Git, a good place to start is the [NHS-R Git Training](https://github.com/nhs-r-community/git_training/). Their [Introduction to Git](https://github.com/nhs-r-community/git_training/blob/main/guides/introduction_to_git.md) will help you understand why version control is necessary, what Git & GitHub can offer, and how to navigate these tools.

### Guides & Source Code

All guides are stored as html files in the /guides subdirectory, but they can be accessed from the links below. The source code for the guides are stored in the /src subdirectory. The source code (.qmd files) can be used to run the code locally.

The easiest way to use any of the guides is to clone this repository to your local machine, so that you have all the files you need for setup.

### Setup

In order to run the code in the Quarto notebooks, you will first have to install all the packages that the code uses, and set up your R environment using [{renv}](https://rstudio.github.io/renv/articles/renv.html).

First, if you haven't already, install {renv}.

```{r}
install.packages("renv")
```

Having done this, you can now restore the R environment from the renv.lock file in the repository.

```{r}
renv::restore()
```

You should now be able to run any of the source code you want!

## Methods

- [Getting Started with R & Python](https://htmlpreview.github.io/?https://github.com/NHS-South-Central-and-West/data-science-guides/blob/main/guides/getting-started.html)
- [Importing Data from SQL](https://htmlpreview.github.io/?https://github.com/NHS-South-Central-and-West/data-science-guides/blob/main/guides/sql.html)
- Exploratory Data Analysis
- Hypothesis Testing (Chi-Squared, T-Test, ANOVA?)
- Regression
  - Linear Regression
  - Generalised Linear Models
  - Multilevel Regression
  - Generalised Additive Models
- Forecasting
- Machine Learning
  - [Supervised Learning (Classification)](https://htmlpreview.github.io/?https://github.com/NHS-South-Central-and-West/data-science-guides/blob/main/guides/machine-learning.html)
  - Unsupervised Learning (Clustering)
- Deep Learning

## Resources

- [R for Data Science](https://r4ds.hadley.nz/)
- [Telling Stories with Data](https://tellingstorieswithdata.com/)
- [StatQuest](https://www.youtube.com/@statquest)
