workspace "dreams-engine"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-${cfg.system}-%{cfg.arhitecture}"

project "Dream"
	location "Dream"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src"
		"%{prj.name}/vendor/spdlog/include"
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
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		define "DR_DEBUG"
		symbols "On"

	filter "configurations:Release"
		define "DR_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		define "DR_DIST"
		optimize "On"

project
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

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
		define "DR_DEBUG"
		symbols "On"

	filter "configurations:Release"
		define "DR_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		define "DR_DIST"
		optimize "On"