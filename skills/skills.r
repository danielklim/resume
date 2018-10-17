Libs <- c(
	'xlsx',
	'tidyverse',
	'Hmisc'
)

Wd <- 'C:/Users/Daniel/Documents/resume'

Fn.skills <- 'skills.xlsx'

library(pacman)
pacman::p_load(char = Libs)
setwd(Wd)

# cc = c('character', rep('numeric', 12))
# turnout = read.xlsx2(Fn.skills, 1, colClasses = cc,  stringsAsFactors = F)

# ggplot(data = Skills %>% filter(priority > 0 & category %in% c('language', 'software')) %>% arrange(factor(category, levels = c('language', 'software')), level)) + geom_col(aes(x = reorder(name, level), y = level, fill = category)) + coord_flip() + theme(legend.position = "right")

Skills <- read.xlsx(Fn.skills, 1, stringsAsFactors = F)
Skills$category <- capitalize(Skills$category)
Skills$category <- factor(Skills$category, levels = c('Language', 'Frontend', 'Skill')) 
Skills <- Skills %>% arrange(category, -level, name)
Skills$order <- 1:nrow(Skills)

# png(filename = "c:/users/daniel/Documents/markdown-resume/src/skills.png",
    # width = 480, height = 640, units = "px", pointsize = 12,
    # bg = "white")

ggplot(data = Skills %>% filter(rt_geosite > 0 & category %in% c('Language', 'Frontend', 'Skill'))) + 
	geom_col(aes(x = reorder(name, order), y = level, fill = category)) + 
	scale_y_continuous(breaks = c(1, 3, 5, 7), labels = c('Novice', 'Intermediate', 'Advanced', 'Expert')) +
	theme(legend.position = "bottom", axis.text.x=element_text(angle=45,hjust=1)) + 
	labs(y = NULL, x = NULL, fill = NULL)

ggsave('c:/users/daniel/documents/markdown-resume/dist/skills.png')
# dev.off()

# ggplot(data = Skills %>% filter(rt_geosite > 0 & category %in% c('Language', 'Frontend', 'Skill'))) + 
# 	geom_col(aes(x = reorder(name, order), y = level, fill = category)) + 
# 	scale_y_continuous(breaks = c(1, 3, 5, 7), labels = c('Novice', 'Intermediate', 'Advanced', 'Expert')) +
# 	theme(legend.position = "bottom") + 
# 	labs(y = 'Proficiency', x = NULL) + 
# 	coord_flip()

## misaligned y axis
requires(gridExtra)

ggplot.skills <- function(Df, Category){
	return(
		ggplot(data = 
			Df %>% 
			filter(rt_general > 0 & category %in% Category) %>% 
			arrange(factor(category, levels = c('language', 'software')), level)
		) + 
		geom_col(aes(x = reorder(name, level), y = level, fill = category)) + 
		coord_flip() + 
		theme(legend.position = "none")
	)
}

Skills.cats <- c('language', 'software')
Skills.plots <- list(
	Language = ggplot.skills(Skills, 'language'),
	Software = ggplot.skills(Skills, 'software')
)

grid.arrange(Skills.plots)