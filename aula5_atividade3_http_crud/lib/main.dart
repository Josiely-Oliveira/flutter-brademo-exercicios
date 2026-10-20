import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ===========================================================================
// Atividade 3 - Requisições HTTP com o JSONPlaceholder
// Operações: GET (um item), GET (lista), POST, PUT e DELETE
// ===========================================================================

// ------------------------------- Modelo ------------------------------------
class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  const Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // De JSON (Map) para Post
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as int?,
        userId: json['userId'] as int? ?? 1,
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );

  // De Post para Map (usado com jsonEncode)
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };

  Post copyWith({int? id, int? userId, String? title, String? body}) => Post(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
      );
}

// ------------------------------- Serviço -----------------------------------
class ApiException implements Exception {
  final int statusCode;
  const ApiException(this.statusCode);

  @override
  String toString() => 'Erro HTTP $statusCode';
}

class PostService {
  static const _host = 'jsonplaceholder.typicode.com';
  static const _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  final http.Client _client;
  PostService([http.Client? client]) : _client = client ?? http.Client();

  void _check(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException(res.statusCode);
    }
  }

  // GET /posts  -> lista
  Future<List<Post>> fetchPosts() async {
    final res = await _client.get(Uri.https(_host, 'posts'));
    _check(res);
    final list = jsonDecode(res.body) as List<dynamic>;
    return list.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  // GET /posts/{id}  -> um item
  Future<Post> fetchPost(int id) async {
    final res = await _client.get(Uri.https(_host, 'posts/$id'));
    _check(res);
    return Post.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  // POST /posts  -> cria
  Future<Post> createPost(Post post) async {
    final res = await _client.post(
      Uri.https(_host, 'posts'),
      headers: _headers,
      body: jsonEncode(post.toJson()),
    );
    _check(res);
    return Post.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  // PUT /posts/{id}  -> atualiza
  Future<Post> updatePost(Post post) async {
    final res = await _client.put(
      Uri.https(_host, 'posts/${post.id}'),
      headers: _headers,
      body: jsonEncode(post.toJson()),
    );
    _check(res);
    return Post.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  // DELETE /posts/{id}  -> remove
  Future<void> deletePost(int id) async {
    final res = await _client.delete(Uri.https(_host, 'posts/$id'));
    _check(res);
  }
}

// ------------------------------- Interface ---------------------------------
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade 3 - JSONPlaceholder',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _service = PostService();
  List<Post> _posts = [];
  bool _loading = true;
  String? _error;

  // O JSONPlaceholder só simula escritas (nada é gravado de verdade). O recurso
  // criado por POST recebe id 101, que não existe no servidor; por isso, para
  // itens com id > 100, atualizamos apenas a lista local.
  bool _isLocalOnly(Post p) => (p.id ?? 0) > 100;

  // Chamado UMA vez no initState (nunca dentro do build()).
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final posts = await _service.fetchPosts();
      if (!mounted) return;
      setState(() => _posts = posts);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  // GET por id
  Future<void> _showDetail(Post p) async {
    try {
      final post = _isLocalOnly(p) ? p : await _service.fetchPost(p.id!);
      if (!mounted) return;
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Post #${post.id}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('userId: ${post.userId}'),
                const SizedBox(height: 8),
                Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(post.body),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar')),
          ],
        ),
      );
    } catch (e) {
      _snack('Falha no GET: $e');
    }
  }

  // POST
  Future<void> _create() async {
    final draft = await showDialog<Post>(
      context: context,
      builder: (_) => const PostFormDialog(),
    );
    if (draft == null) return;
    try {
      final created = await _service.createPost(draft);
      if (!mounted) return;
      setState(() => _posts.insert(0, created));
      _snack('POST ok: criado com id ${created.id} (simulado pelo servidor)');
    } catch (e) {
      _snack('Falha no POST: $e');
    }
  }

  // PUT
  Future<void> _edit(Post p) async {
    final edited = await showDialog<Post>(
      context: context,
      builder: (_) => PostFormDialog(initial: p),
    );
    if (edited == null) return;
    try {
      final updated = _isLocalOnly(edited) ? edited : await _service.updatePost(edited);
      if (!mounted) return;
      setState(() {
        final i = _posts.indexWhere((x) => x.id == p.id);
        if (i != -1) _posts[i] = updated;
      });
      _snack('PUT ok: post ${updated.id} atualizado');
    } catch (e) {
      _snack('Falha no PUT: $e');
    }
  }

  // DELETE
  Future<void> _delete(Post p) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir post?'),
        content: Text('Post #${p.id}: ${p.title}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      if (!_isLocalOnly(p)) await _service.deletePost(p.id!);
      if (!mounted) return;
      setState(() => _posts.removeWhere((x) => x.id == p.id));
      _snack('DELETE ok: post ${p.id} removido');
    } catch (e) {
      _snack('Falha no DELETE: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            const SizedBox(height: 12),
            FilledButton(onPressed: _loadPosts, child: const Text('Tentar novamente')),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: _loadPosts,
        child: ListView.separated(
          itemCount: _posts.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final p = _posts[i];
            return ListTile(
              leading: CircleAvatar(child: Text('${p.id}')),
              title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(p.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () => _showDetail(p),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Editar (PUT)',
                    icon: const Icon(Icons.edit),
                    onPressed: () => _edit(p),
                  ),
                  IconButton(
                    tooltip: 'Excluir (DELETE)',
                    icon: const Icon(Icons.delete),
                    onPressed: () => _delete(p),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder - Posts'),
        actions: [
          IconButton(
            tooltip: 'Recarregar lista (GET)',
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: const Text('Novo (POST)'),
      ),
    );
  }
}

// Formulário usado tanto para criar (POST) quanto para editar (PUT).
class PostFormDialog extends StatefulWidget {
  final Post? initial;
  const PostFormDialog({super.key, this.initial});

  @override
  State<PostFormDialog> createState() => _PostFormDialogState();
}

class _PostFormDialogState extends State<PostFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title =
      TextEditingController(text: widget.initial?.title ?? '');
  late final TextEditingController _body =
      TextEditingController(text: widget.initial?.body ?? '');

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final base = widget.initial ?? const Post(userId: 1, title: '', body: '');
    Navigator.pop(context, base.copyWith(title: _title.text.trim(), body: _body.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.initial != null;
    return AlertDialog(
      title: Text(editing ? 'Editar post #${widget.initial!.id}' : 'Novo post'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o título' : null,
              ),
              TextFormField(
                controller: _body,
                decoration: const InputDecoration(labelText: 'Conteúdo'),
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o conteúdo' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(onPressed: _submit, child: Text(editing ? 'Salvar (PUT)' : 'Criar (POST)')),
      ],
    );
  }
}
