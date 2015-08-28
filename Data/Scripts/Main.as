Scene@ scene_; // указатель на сцену


void Start()
{
    // Создаем новую сцену.
    scene_ = Scene();
    
    // Сцена является производым от ноды типом и к ней тоже
    // можно добавлять компоненты. Компонент Octree (октодерево)
    // необходим, если вы планируете отображать объекты сцены,
    // то есть почти всегда.
    scene_.CreateComponent("Octree");
    
    // Создаем для сцены дочернюю ноду и задаем ей имя MyCamera.
    // Имена нод можно использовать для того, чтобы искать нужный узел сцены.
    Node@ cameraNode = scene_.CreateChild("MyCamera");
    
    // Создаем камеру и прикрепляем ее к узлу.
    cameraNode.CreateComponent("Camera");
    
    // Указываем для узла с камерой положение в пространстве.
    // Координата X направлена слева направо, Y - снизу вверх, Z - от вас вглубь экрана.
    cameraNode.position = Vector3(0.0f, 0.0f, -5.0f);
    
    // Указываем движку какая камера какой сцены будет показываться на экране.
    Viewport@ viewport = Viewport(scene_, cameraNode.GetComponent("Camera"));
    renderer.viewports[0] = viewport;


    // Создаем ноду для 3D-модели.
    Node@ boxNode = scene_.CreateChild("MyBox");
    
    // Создаем компонент StaticModel - простая 3D-модель без скелета.
    StaticModel@ boxObject = boxNode.CreateComponent("StaticModel");
    
    // Загружаем модель из файла.
    // Если эта модель уже была загружена ранее, то она не будет загружаться повторно.
    boxObject.model = cache.GetResource("Model", "Models/Box.mdl");
    
    // Повернем узел с кубом (все значения указываются в градусах).
    boxNode.rotation = Quaternion(45.0f, 45.0f, 45.0f);


    // Создаем ноду для источника света.
    Node@ lightNode = scene_.CreateChild("MyLight");
    
    // Создаем источник света и прикрепляем к ноде.
    Light@ light = lightNode.CreateComponent("Light");
    
    // Указываем тип источника света - солнечный свет.
    light.lightType = LIGHT_DIRECTIONAL;
    
    // Указываем направление света.
    lightNode.direction = Vector3(0.6f, -0.6f, 0.8f);


    // Определяем функцию, которая будет вызываться каждый кадр.
    SubscribeToEvent("Update", "HandleUpdate");
}


// Обработчик события Update.
void HandleUpdate(StringHash eventType, VariantMap& eventData)
{
    // Сколько времени прошло с предыдущего кадра.
    float timeStep = eventData["TimeStep"].GetFloat();
    
    // Находим ноду с нашим кубом.
    Node@ boxNode = scene_.GetChild("MyBox");
    
    // Поворачиваем ее.
    boxNode.Rotate(Quaternion(10.0f * timeStep, 10.0f * timeStep, 10.0f * timeStep));
}

