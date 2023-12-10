#include "drpch.h"
#include "Application.h"

#include "Dream/Events/ApplicationEvent.h"
#include "Dream/Log.h"

namespace Dream {

	Application::Application()
	{
		m_Window = std::unique_ptr<Window>(Window::Create());
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		while (m_Running)
		{
			m_Window->OnUpdate();
		}
	}

}