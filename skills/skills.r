Libs <- c(
	'xlsx',
	'tidyverse',
	'Hmisc'
)

Wd <- 'C:/Users/Daniel/Documents/resume/skills'

Fn.skills <- 'skills.xlsx'

library(pacman)
pacman::p_load(char = Libs)
setwd(Wd)

Skills <- read.xlsx(Fn.skills, 1, stringsAsFactors = F)
# Skills$category <- capitalize(Skills$category)

## geosite
categories.geosite <- c(language='Language', frontend='Frontend', skill='Skill')
Skills$category <- do.call(function(...){recode(Skills$category, ...)}, split(unname(categories.geosite), names(categories.geosite)))
Skills$category <- factor(Skills$category, levels = categories.geosite) 
Skills <- Skills %>% arrange(category, -level, name)
Skills$order <- 1:nrow(Skills)

ggplot(data = Skills %>% filter(rt_geosite > 0 & category %in% categories.geosite)) + 
	geom_col(aes(x = reorder(name, order), y = level, fill = category)) + 
	scale_y_continuous(breaks = c(1, 3, 5, 7), labels = c('Novice', 'Intermediate', 'Advanced', 'Expert')) +
	theme(legend.position = "bottom", axis.text.x=element_text(angle=45,hjust=1)) + 
	labs(y = NULL, x = NULL, fill = NULL)

ggsave('c:/users/daniel/documents/resume/skills/geosite.png')

## general
categories.general <- c(skill='Tech Skill', soft='Soft Skill', language='Language')
Skills$category <- do.call(function(...){recode(Skills$category, ...)}, split(unname(categories.general), names(categories.general)))
Skills$category <- factor(Skills$category, levels = categories.general) 
Skills <- Skills %>% arrange(category, -level, name)
Skills$order <- 1:nrow(Skills)

ggplot(data = Skills %>% filter(rt_general > 0 & category %in% categories.general)) + 
	geom_col(aes(x = reorder(name, order), y = level, fill = category)) + 
	scale_y_continuous(breaks = c(1, 3, 5, 7), labels = c('Novice', 'Intermediate', 'Advanced', 'Expert')) +
	scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
	theme(legend.position = "bottom", axis.text.x=element_text(angle=45,hjust=1)) + 
	labs(y = NULL, x = NULL, fill = NULL)

ggsave('c:/users/daniel/documents/resume/skills/general.png', width=6.5, height=3.5, units='in')
