<p align="center">

  <h3 align="center">MOCK UP DATA GENERATOR</h3>

  <p align="center">
    Generator of the output stage and sample data from the GoodData model.
    <br />
    <a href="https://github.com/shtyler/datagenerator"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/shtyler/datagenerator">View Demo</a>
    ·
    <a href="https://github.com/shtyler/datagenerator/issues">Report Bug</a>
    ·
    <a href="https://github.com/shtyler/datagenerator/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project

### Problem ### 
* Missing data with nearly every customer implementation. Why?
  * Security reasons
  * Development time on customer side 
  * Integration issues 
  * Development of custom connector in GD
* Precious time spent on DDL scripts + whatever ad hoc data generation => problems with referential integrity
* Professional services can jump right on the solution without any blockers

### Solution ### 
* Let’s use just LDM to generate data
* LDM.json has all necessary information to generate mock up data
* LDM can be built quickly and it is (usually) starting point for each project
* LDM.json file can be downloaded and used in SQL executor as list of parameters for .liquid template
* In other words: Match made in heaven


<!-- GETTING STARTED -->
## Getting Started
1. Clone this git repo and load the `datagen` folder to your S3 bucket
2. Update `/param_definitions/LDM.json` with your freshly created LDM from the WEB modeler (/admin/modeler/#/projects/{pid}). WARNING: LDM.json must be in ASCII encoding.
3. Set up your output stage (OS) prefix (default is `out_generated_vw_`) 
4. (Optional) Change default OS prefix in all 3 liquid templates `{%-assign out_prefix = "out_generated_vw_" -%}`
5. (Optional) Load custom input to the table `csv_custom_values`
6. Deploy & Run SQL executor to trigger `01_run_datagen.sql`
7. Schedule & Run ADD to upload data to WS



<!-- USAGE EXAMPLES -->
## Usage

### Example 1 - Creating the output stage.
Sometimes all you need is to create an output stage according to the model. OS consists of out_ tables and out_vw_ views on top of the out_ tables. 
If that is the case all you need to run is **1_generate_os.liquid**. Change the 01_mock_up_data.sql to run only this template - leave only first row - and you are good to go.
By running the script you will generate OS.

### Example 2 - Creating the output stage and populating it with mockup data.
Mock up data are generated under simple principles with respect to referential integrity. By default, number of records in dimension table, fact table and number of random values in attributes are set to certain values. 
These can be changed in the template. Date values are always generated within previous 300 days. To run mockup data generation you need to run generate OS and **2_populate_os.liquid** template. Adjust 01_mock_up_data.sql accordingly.

### Example 3 - Creating the output stage, populating it with mockup data and updating it with custom values.
If you need to use your custom values in the attributes or facts you can load them to `csv_custom_values` table with following structure (dataset, field, values) by using copy command. 
`dataset` and `field` have to match values in the LDM (last part of the identifier). In `values` you can use either list of values separated by comma (`,`) 
or range of values separated by dash (`-`). Real values for the particular field will be generated randomly from the given list or range. 
_The solution does not yet support custom values for dates, connection points and references._
To run update with custom values you need to run generate OS, populate OS and **3_update_os.liquid**. Adjust 01_mock_up_data.sql accordingly.

## Run on Local
If you don't want to set up the SQL Executor to generate the code you can render the templates on the local machine using Ruby. 
Update the `datagen/param_definitions/LDM.json` with your LDM, update the script `run_local.rb` to render required template and then simply run the script `jruby run_local.rb`. It will generate the SQL which you can then use in the ADS.



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/shtyler/datagenerator/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Your Name - [@pbobkov](https://twitter.com/pbobkov) - pavel.bobkov@gooddata.com

Project Link: [https://github.com/shtyler/datagenerator](https://github.com/shtyler/datagenerator)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* Thanks to my mom
* [Thanks to Michal Nikodem](https://www.linkedin.com/in/michalnikodem/)
* [Thanks to GoodData](www.gooddata.com/data-sources)
 
-> without them and those it would not have happened



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo.svg?style=flat-square
[contributors-url]: https://github.com/github_username/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo.svg?style=flat-square
[forks-url]: https://github.com/github_username/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo.svg?style=flat-square
[stars-url]: https://github.com/github_username/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo.svg?style=flat-square
[issues-url]: https://github.com/github_username/repo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo.svg?style=flat-square
[license-url]: https://github.com/github_username/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/github_username
[product-screenshot]: images/screenshot.png
