local fontfiles = {
	"Lato-Black",
	"Lato-BlackItalic",
	"Lato-Bold",
	"Lato-BoldItalic",
	"Lato-Light",
	"Lato-LightItalic",
	"Lato-Regular",
	"Lato-Italic"
}

for i = 1, #fontfiles do
	resource.AddFile("resource/fonts/" .. fontfiles[i])
end