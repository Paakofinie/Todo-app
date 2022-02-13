import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paakofinie_to_do_app/create_todo_view.dart';
import 'package:paakofinie_to_do_app/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = 'todo';

  final List<Map<String, dynamic>> _unCompletedData = [];

  final List<Map<String, dynamic>> _completedData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title':
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ',
      'description': '',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title':
          'Integer tincidunt. Cras dapibus. Vivamus elementum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ',
      'description':
          ' Nullam dictum felis eu pede mollis pretium.  semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.',
      'date_time': 'Today',
      'status': true,
    },
    {
      'title':
          ' Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ',
      'description':
          ' Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncusAenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title':
          'Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncusLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ',
      'description':
          'Nam eget dui. , sem quam semper libero,Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus.',
      'date_time': 'Today',
      'status': false,
    },
    {
      'title':
          'sem quam semper quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ',
      'description':
          'Nam eget dui. Etiam rhoncus. Maecenas tempus, libero, sit amet adipiscing sem neque sed ipsum. Nam tellus eget condimentum rhoncus,  Donec vitae sapien ut libero venenatis faucibus.',
      'date_time': 'Mon, 15 Nov',
      'status': false,
    }
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _unCompletedData.add(element);
      } else {
        _completedData.add(element);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'My Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          leading: const Center(
              child: FlutterLogo(
            size: 40,
          )),
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.menu),
                onSelected: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Todo'),
                      value: 'todo',
                    ),
                    const PopupMenuItem(
                      child: Text('Completed'),
                      value: 'completed',
                    )
                  ];
                }),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateTodoView();
            }));
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return TaskCardWidge(
                dateTime: selectedItem == 'todo'
                    ? _unCompletedData[index]['date_time']
                    : _completedData[index]['date_time'],
                title: selectedItem == 'todo'
                    ? _unCompletedData[index]['title']
                    : _completedData[index]['title'],
                description: selectedItem == 'todo'
                    ? _unCompletedData[index]['description']
                    : _completedData[index]['description'],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: selectedItem == 'todo'
                ? _unCompletedData.length
                : _completedData.length),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return TaskCardWidge(
                              dateTime: _completedData[index]['date_time'],
                              description: _completedData[index]['description'],
                              title: _completedData[index]['title'],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: _completedData.length);
                    });
              },
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(37, 43, 103, 1),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${_completedData.length}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class TaskCardWidge extends StatelessWidget {
  const TaskCardWidge(
      {Key? key,
      required this.title,
      required this.description,
      required this.dateTime})
      : super(key: key);

  final String title;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 30,
              color: customColor(date: dateTime),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(37, 43, 103, 1)),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            )),
            const SizedBox(width: 15),
            Row(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: customColor(date: dateTime),
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                    color: customColor(date: dateTime),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
