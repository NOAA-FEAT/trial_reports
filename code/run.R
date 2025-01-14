#' ---------------------------------------------
#' title: 'Data Report: MAXYR Eastern Bering Sea continental shelf Bottom Trawl Survey of Groundfish and Invertebrate Fauna'
#' author: E. H. Markowitz, E. J. Dawson
#' purpose: Run Scripts and R Markdown Files
#' start date: 2021-09-01
#' date modified: 2022-09-01                                          # CHANGE
#' Notes:  
#' Compile master word doc using # https://support.microsoft.com/en-us/help/2665750/how-to-merge-multiple-word-documents-into-one
#' create file that checks for errors in RMDs:
#'    https://github.com/NOAA-EDAB/esp_data_aggregation/blob/main/R-scripts/test_rmds.R
#'    https://github.com/NOAA-EDAB/esp_data_aggregation/blob/main/R-scripts/render%20dev%20report%20with%20errors.R
#'    # rmarkdown::render(input = "./notforgit/test.Rmd",
#'                   output_dir = dir_out_chapters,
#'                   output_file = "test.docx")
#' ---------------------------------------------

# DATA REPORT ------------------------------------------------------------------

# *** Report knowns ------------------------------------------------------------

report_title <- "data" # Fake until I get a better idea of how to automate something down the line
workfaster <- FALSE # an attempt to satisfy limited patience
refcontent <- FALSE # produce extra summary text and tables for each spp to help with writing
googledrive_dl <- TRUE # redownload google drive tables and docs?
indesign_flowin <- FALSE
pres_img <- FALSE
usePNGPDF <- "png"
font0 <- "Arial Narrow"

# maxyr <- 2017 # or the year of the report, for example
# compareyr <- 2010
# strat_yr <- 2010
# SRVY<-"NEBS"
# ref_compareyr <- "@RN976"
# # ref_compareyr <- "@RN909"
# # dir_googledrive <- "1vtwfDwRprFml_5wN_WkeVViynwGhC8fe" # https://drive.google.com/drive/folders/1vtwfDwRprFml_5wN_WkeVViynwGhC8fe?usp=sharing

maxyr <- 2018 # NOTE RAPID RESPONCE
strat_yr <- 2019
compareyr <- 2016
SRVY<-"EBS"
ref_compareyr <- "@RN976" # CHANGE
dir_googledrive <- "1W8VfqBF9j48vk0GpFLyg5cZGzuHlelAy" # https://drive.google.com/drive/folders/1W8VfqBF9j48vk0GpFLyg5cZGzuHlelAy?usp=sharing

maxyr <- 2019
compareyr <- 2017
strat_yr <- 2019
SRVY<-"NEBS"
ref_compareyr <- "@Lauth2019" # CHANGE
dir_googledrive <- "1HpuuIIp6piS3CieRJR81-8hVJ3QaKOU-" # https://drive.google.com/drive/folders/1HpuuIIp6piS3CieRJR81-8hVJ3QaKOU-?usp=sharing

# maxyr <- 2021
# compareyr <- 2019
# strat_yr <- 2019
# SRVY <- "EBS" # "NEBS"
# ref_compareyr <- "@2019NEBS2022" # CHANGE
# dir_googledrive <- "1i3NRmaAPpIYfMI35fpJCa-8AjefJ7J7X" # https://drive.google.com/drive/folders/1i3NRmaAPpIYfMI35fpJCa-8AjefJ7J7X?usp=sharing

maxyr <- 2022
compareyr <- 2021
strat_yr <- 2022
SRVY<-"NEBS"
ref_compareyr <- "@2021NEBS2022" # CHANGE
dir_googledrive <- "1x50OKqAyLcqNLYhjQNX84dHLXHcTBnaD" # https://drive.google.com/drive/folders/1x50OKqAyLcqNLYhjQNX84dHLXHcTBnaD

googledrive::drive_deauth()
googledrive::drive_auth()
1

# *** Source support scripts ---------------------------------------------------

source('./code/directories.R')

source('./code/functions.R')

# source('./code/data_dl.R') # Run when there is new data!

source('./code/data.R')

# csl <- readLines("https://raw.githubusercontent.com/citation-style-language/styles/master/american-fisheries-society.csl")
# readr::write_lines(x = csl, file = "./cite/citestyle.csl")

# *** Figures and Tables ------------------------

report_spp1 <- add_report_spp(spp_info = spp_info, 
                              spp_info_codes = "species_code", 
                              report_spp = report_spp, 
                              report_spp_col = "order", 
                              report_spp_codes = "species_code", 
                              lang = FALSE)

# General figures
filename0<-paste0(cnt_chapt, "_")
rmarkdown::render(paste0(dir_code, "/figtab.Rmd"),
                  output_dir = dir_out_ref,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# Species figures
for (jj in 1:length( unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))] )) {
  
  print(paste0(jj, " of ", length(unique(report_spp1$file_name)), ": ", unique(report_spp1$file_name)[jj]))
  filename00<-paste0(cnt_chapt, "_spp_")
  rmarkdown::render(paste0(dir_code, "/figtab_spp.Rmd"),
                    output_dir = dir_out_ref,
                    output_file = paste0(filename00, cnt_chapt_content, "_", 
                                         unique(report_spp1$file_name)[jj],".docx"))
}

# Appendix 
filename0<-paste0(cnt_chapt, "_")
rmarkdown::render(paste0(dir_code, "/figtab_appendix.Rmd"),
                  output_dir = dir_out_ref,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# Save
save(list_figures,
     file=paste0(dir_out_figures, "/report_figures.rdata"))

save(list_tables,
     file=paste0(dir_out_tables, "/report_tables.rdata"))

# load(file = paste0(dir_out_figures, "/report_figures.rdata"))
# load(file = paste0(dir_out_tables, "/report_tables.rdata"))

# *** 01 - Abstract ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_abstract_")
rmarkdown::render(input = paste0(dir_code, "/01_abstract.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 02 - Introduction ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_introduction_")
rmarkdown::render(paste0(dir_code, "/02_introduction.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 04 - Methods ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_methods_")
rmarkdown::render(paste0(dir_code, "/04_methods.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 05 - Results ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_results_")
rmarkdown::render(paste0(dir_code, "/05_results.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 06 - Results_spp ------------------------
report_spp1 <- add_report_spp(spp_info = spp_info, 
                              spp_info_codes = "species_code", 
                              report_spp = report_spp, 
                              report_spp_col = "order", 
                              report_spp_codes = "species_code", 
                              lang = TRUE)
cnt_chapt<-auto_counter(cnt_chapt)

for (jj in 1:length( unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))] )) {
  
  print(paste0(jj, " of ", length(unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))]), ": ", unique(report_spp1$file_name)[jj]))
  
  cnt_chapt_content<-auto_counter(cnt_chapt_content)
  filename00<-paste0(cnt_chapt, "_spp_")
  rmarkdown::render(paste0(dir_code, "/06_results_spp.Rmd"),
                    output_dir = dir_out_chapters,
                    output_file = paste0(filename00, cnt_chapt_content, "_", 
                                         unique(report_spp1$file_name)[jj],".docx"))
}

# *** 09 - Endmatter ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_endmatter_")
rmarkdown::render(paste0(dir_code, "/10_endmatter.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 10 - Appendix ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_appendix_")
rmarkdown::render(paste0(dir_code, "/09_appendix.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))


# COMMUNITY HIGHLIGHTS ---------------------------------------------------------

# *** Report knowns ------------------------------------------------------------

# report_title <- paste0(maxyr, ' Northern Bering Sea Groundfish and Crab Trawl Survey Highlights')
report_title <- "community" # Fake until I get a better idea of how to automate something down the line
workfaster <- FALSE # an attempt to satisfy limited patience
refcontent <- FALSE # produce extra summary text and tables for each spp to help with writing
googledrive_dl <- TRUE # redownload google drive tables and docs?
indesign_flowin <- FALSE
pres_img <- FALSE
usePNGPDF <- "png"
font0 <- "Arial Narrow"

SRVY <- "NEBS"

# # 2019
# report_yr <- maxyr <- 2019
# compareyr <- 2010
# ref_compareyr_ebs <- "@RN976" # check
# ref_compareyr_nbs <- "@RN909" # check

# # 2021
# report_yr <- maxyr <- 2021
# compareyr <- c(2019)# , 2017, 2010)
# ref_compareyr_ebs <- "@RN976" # check
# ref_compareyr_nbs <- "@RN909" # check
# id_googledrive <- googledrive::as_id("1bqXIlM9Er8MeITCkRQy8D52Yd46CLz3f")

# 2022
report_yr <- maxyr <- 2022
compareyr <- 2021
ref_compareyr_ebs <- ref_compareyr <- "@2021NEBS2022" # check
ref_compareyr_nbs <- "@RN909" # check
dir_googledrive <- "1uZy1uDB_poml2KKX3R_Qv8qrWG1WLewE" # "https://drive.google.com/drive/folders/1uZy1uDB_poml2KKX3R_Qv8qrWG1WLewE")
strat_yr <- 2022

googledrive::drive_deauth()
googledrive::drive_auth()
1

# *** Source support scripts ---------------------------------------------------

source('./code/directories.R')

source('./code/functions.R')

# source('./code/data_dl.R') # Run when there is new data!

source('./code/data.R')

# *** Figures and Tables ------------------------
report_spp1 <- add_report_spp(spp_info = spp_info, 
                              spp_info_codes = "species_code", 
                              report_spp = report_spp, 
                              report_spp_col = "order", 
                              report_spp_codes = "species_code", 
                              lang = FALSE)

# General figures
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_")
rmarkdown::render(paste0(dir_code, "/figtab_c.Rmd"),
                  output_dir = dir_out_ref,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# Species figures
for (jj in 1:length( unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))] )) {
  print(paste0(jj, " of ", length(unique(report_spp1$file_name)), ": ", unique(report_spp1$file_name)[jj]))
  filename00 <- paste0(cnt_chapt, "_spp_")
  rmarkdown::render(paste0(dir_code, "/figtab_spp.Rmd"),
                    output_dir = dir_out_ref,
                    output_file = paste0(filename00, cnt_chapt_content, "_", 
                                         unique(report_spp1$file_name)[jj],".docx"))
}

# Save
save(list_figures,
     file=paste0(dir_out_figures, "/report_figures.rdata"))

save(list_tables,
     file=paste0(dir_out_tables, "/report_tables.rdata"))

# load(file = paste0(dir_out_figures, "/report_figures.rdata"))
# load(file = paste0(dir_out_tables, "/report_tables.rdata"))

# *** 1 - Introduction ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_introduction_")
rmarkdown::render(paste0(dir_code, "/c1_introduction.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))


# *** 2 - Survey_design ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_survey_design_")
rmarkdown::render(paste0(dir_code, "/c2_survey_design.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 3 - Survey_snapshot_compare ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_survey_snapshot_compare_")
rmarkdown::render(paste0(dir_code, "/c3_survey_snapshot_compare.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# *** 5 - Results_spp ------------------------
report_spp1 <- add_report_spp(spp_info = spp_info, 
                              spp_info_codes = "species_code", 
                              report_spp = report_spp, 
                              report_spp_col = "order", 
                              report_spp_codes = "species_code", 
                              lang = TRUE)
cnt_chapt<-auto_counter(cnt_chapt)

for (jj in 1:length( unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))] )) {
  
  print(paste0(jj, " of ", length(unique(report_spp1$file_name)[!is.na(unique(report_spp1$file_name))]), ": ", unique(report_spp1$file_name)[jj]))
  
  cnt_chapt_content<-auto_counter(cnt_chapt_content)
  filename00<-paste0(cnt_chapt, "_spp_")
  rmarkdown::render(input = paste0(dir_code, "/06_results_spp.Rmd"),
                    output_dir = dir_out_chapters,
                    output_file = paste0(filename00, cnt_chapt_content, "_", 
                                         unique(report_spp1$file_name)[jj],".docx"))
}

# *** 7 - App_scientistprofiles ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_survey_team_bios_")
file.copy(from = paste0(dir_out_rawdata, "0_survey_team_bios.docx"),
          to = paste0(dir_out_chapters, filename0, cnt_chapt_content, ".docx"), 
          overwrite = TRUE)

# *** 6 - Endmatter ------------------------
cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_endmatter_")
rmarkdown::render(paste0(dir_code, "/10_endmatter.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))

# PRESENTATION ------------------------------------------------------

report_spp1 <- add_report_spp(spp_info = spp_info, 
                              spp_info_codes = "species_code", 
                              report_spp = report_spp, 
                              report_spp_col = "order", 
                              report_spp_codes = "species_code0", 
                              lang = TRUE)

# #  report_spp1 <- report_spp1 %>%
#     dplyr::filter(!(file_name %in% c("sturgeon_poacher", "red_king_crab"
#                                      ,"blue_king_crab","snow_crab"
#                                      ,"tanner_crab","varigated_snailfish")))

# report_spp1 <- report_spp1 %>%
#   dplyr::filter((file_name %in% 
#                    c("walleye_pollock",
#                      "pacific_cod",
#                      "yellowfin_sole",
#                      "northern_rock_sole",
#                      "flathead_sole",
#                      "bering_flounder",
#                      "alaska_plaice",
#                      "greenland_turbot",
#                      "arrowtooth_flounder",
#                      "kamchatka_flounder",
#                      "pacific_halibut",
#                      "bering_skate",
#                      "alaska_skate",
#                      "plain_sculpin",
#                      "great_sculpin",
#                      "shorthorn_sculpin",
#                      "pacific_ocean_perch",
#                      "rex_sole"#,
#                      # "arctic_cod",
#                      # "saffron_cod"
#                    )))

yrs <- sort(nbsyr, decreasing = FALSE)

# *** Figures and Tables ------------------------
# if (FALSE) {

cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_")
rmarkdown::render(paste0(dir_code, "/figtab_pres.Rmd"),
                  output_dir = dir_out_ref,
                  output_file = paste0(filename0, cnt_chapt_content, ".docx"))


for (jj in 1:length(unique(report_spp1$file_name))) {
  
  print(paste0(jj, " of ", length(unique(report_spp1$file_name)), ": ", unique(report_spp1$file_name)[jj]))
  SRVY1 <- c("NBS", "EBS")
  pcol <- viridis::mako(n = 2, begin = .2, end = .6, direction = -1) # TOLEDO - need to find out where this is outside of a function
  
  filename00<-paste0(cnt_chapt, "_spp_")
  rmarkdown::render(paste0(dir_code, "/figtab_spp_pres.Rmd"),
                    output_dir = dir_out_ref,
                    output_file = paste0(filename00, cnt_chapt_content, "_", 
                                         unique(report_spp1$file_name)[jj],".docx"))
}

save(list_figures,
     file=paste0(dir_out_figures, "/report_figures_pres.rdata"))

save(list_tables,
     file=paste0(dir_out_tables, "/report_tables_pres.rdata"))

# }

cnt_chapt<-auto_counter(cnt_chapt)
cnt_chapt_content<-"001"
filename0<-paste0(cnt_chapt, "_presentation_")
rmarkdown::render(paste0(dir_code, "/11_presentation.Rmd"),
                  output_dir = dir_out_chapters,
                  output_file = paste0(filename0, cnt_chapt_content, ".pptx"))

# SAVE METADATA ----------------------------------------------------------------
rmarkdown::render(paste0("./README.Rmd"),
                  output_dir = "./",
                  output_file = paste0("README.md"))


con <- file(paste0(dir_out_todaysrun, "metadata.log"))
sink(con, append=TRUE)
sessionInfo()
sink() # Restore output to console
# cat(readLines("notes.log"), sep="\n") # Look at the log

