#include <Dream.h>

class ExampleLayer : public Dream::Layer
{
public: 
	ExampleLayer() 
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		DR_INFO("ExampleLayer::OnUpdate");
	}

	void OnEvent(Dream::Event& event) override
	{
		DR_TRACE("{0}", event);
	}
};

class Sandbox : public Dream::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}

	~Sandbox()
	{

	}
};

Dream::Application* Dream::CreateApplication()
{
	return new Sandbox();
}
