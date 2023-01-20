# Data Science Templates

A repository containing worked examples in R & (eventually) Python of some common data science tasks, to use as a space for learning how to implement these methods, and as a template for applying data science to SCW work.

## Usage

If you are new to Git, a good place to start is the [NHS-R Git Training](https://github.com/nhs-r-community/git_training/). Their [Introduction to Git](https://github.com/nhs-r-community/git_training/blob/main/guides/introduction_to_git.md) will help you understand why version control is necessary, what Git & GitHub can offer, and how to navigate these tools.

### Guides & Source Code

All guides and source code are stored in the /src subdirectory. Quarto (.qmd) notebooks are the source code, and can be used to run the code locally, while Markdown (.md) files are the guides, containing outputs and visualizations along with the code itself.

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

- Importing Data from SQL
- Exploratory Data Analysis
- Hypothesis Testing (Chi-Squared, T-Test, ANOVA?)
- Regression
  - Linear Regression
  - Generalised Linear Models
  - Multilevel Regression
  - Generalised Additive Models
- Forecasting
- Machine Learning
  - Supervised Learning (Classification)
  - Unsupervised Learning (Clustering)
- Deep Learning

## Resources

- [R for Data Science](https://r4ds.hadley.nz/)
- [Telling Stories with Data](https://tellingstorieswithdata.com/)
- [StatQuest](https://www.youtube.com/@statquest)
