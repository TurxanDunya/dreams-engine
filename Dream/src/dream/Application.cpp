#include "drpch.h"
#include "Application.h"

#include "Dream/Events/ApplicationEvent.h"
#include "Dream/Log.h"

namespace Dream {

	Application::Application()
	{
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		WindowResizeEvent e(1280, 720);
		DR_TRACE(e);

		while (true)
		{

		}
	}

}