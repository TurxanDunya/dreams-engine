#pragma once

#ifdef DR_PLATFORM_WINDOWS

extern Dream::Application* Dream::CreateApplication();

int main(int argc, char** argv)
{
	Dream::Log::Init();
	DR_CORE_INFO("Dream Engine started!");
	
	auto app = Dream::CreateApplication();
	app->Run();
	delete app;
}

#endif