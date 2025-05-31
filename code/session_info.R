# session_info.R
# Capture R session information for reproducibility
sessionInfo() %>%
  capture.output(file = "session_info.txt")
