workspace "dreams-engine"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Dream/vendor/GLFW/include"

include "Dream/vendor/GLFW"

project "Dream"
	location "Dream"
	kind "SharedLib"
	language "C++"
	
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	staticruntime "on"

	pchheader "drpch.h"
	pchsource "Dream/src/drpch.h"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib",
		"dwmapi.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"DR_PLATFORM_WINDOWS",
			"DR_BUILD_DLL"
		}

		postbuildcommands
		{
			'{COPY} "%{cfg.buildtarget.relpath}" "../bin/' .. outputdir .. '/Sandbox/"'
		}

	filter "configurations:Debug"
		defines { "DR_DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "DR_RELEASE" }
		optimize "On"

	filter "configurations:Dist"
		defines { "DR_DIST" }
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Dream/vendor/spdlog/include",
		"Dream/src"
	}

	links
	{
		"Dream"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"DR_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines { "DR_DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "DR_RELEASE" }
		optimize "On"

	filter "configurations:Dist"
		defines { "DR_DIST" }
		optimize "On"