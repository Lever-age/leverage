# Some quick numbers

donorFeaturesLong <- donorFeaturesClassified %>% 
  gather("Candidate", "Amount", -Donor, -DonorType)

donorStats <- donorFeaturesLong %>% 
  group_by(Donor, DonorType) %>% 
  summarize(TotalDonations = sum(Amount, na.rm = TRUE), 
            NumberDonations = sum(!is.na(Amount)))

table(donorStats$DonorType)
#>  ideological transactional 
#>        11891            43

sem <- function(x) {
  sd(x)/sqrt(length(x))
}

ggplot(donorStats, aes(x = DonorType, y = TotalDonations, fill = factor(DonorType))) +
  geom_violin() +
  scale_y_log10() +
  labs(y = "Total donated (all campaigns)", x = "") + 
  theme_minimal()
ggsave("donation_amounts.png")

ggplot(donorStats, aes(x = DonorType, y = NumberDonations, color = factor(DonorType))) +
  geom_jitter() +
  labs(y = "Number of campaigns supported", x = "") +
  theme_minimal() +
  theme(legend.position="none")
ggsave("number_donations.png")
