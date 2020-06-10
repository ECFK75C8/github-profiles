import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// import '../widgets/my_app_bar.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/user_item.dart';
import '../providers/users.dart' show Users;

class GithubUsersScreen extends StatefulWidget {
  final String title;

  GithubUsersScreen({Key key, this.title}) : super(key: key);

  @override
  _GithubUsersScreenState createState() => _GithubUsersScreenState();
}

class _GithubUsersScreenState extends State<GithubUsersScreen> {
  final scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var _location = 'lagos';
  var _pageNum = 1;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) => _loadData(_pageNum));
    scrollController.addListener(() {
      if (_isLoading) return;

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) _loadData(_pageNum);
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void _performSearch(String input) {
    if (_isLoading) return;
    _pageNum = 1;
    _location = input;
    Provider.of<Users>(context, listen: false).clear();
    _loadData(_pageNum);
  }

  Future<void> _doReresh() async {
    if (_isLoading) return;

    _pageNum = 1;
    Provider.of<Users>(context, listen: false).clear();
    _loadData(_pageNum);
  }

  void _loadData(int page) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Users>(context, listen: false)
        .fetchUsers(pageNum: page, location: _location)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
      _pageNum += 1;
    }).catchError((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return !_isLoading
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SpinKitThreeBounce(
                size: 30.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(_performSearch),
        body: RefreshIndicator(
          onRefresh: _doReresh,
          child: Consumer<Users>(
            builder: (_, userData, child) => ListView.builder(
              controller: scrollController,
              itemCount: userData.users.length + 1,
              itemBuilder: (_, index) {
                if (index == userData.users.length) {
                  return _buildProgressIndicator(context);
                }
                var user = userData.users[index];
                return UserItem(
                  username: user.username,
                  avatarUrl: user.avatarUrl,
                  location: _location,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
