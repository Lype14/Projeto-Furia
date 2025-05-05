import 'dart:convert';
import 'dart:io';

import 'package:aplicativo_furia/shared/constants/consts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> criarVectorStore() async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/vector_stores'),
    headers: {
      'Authorization': 'Bearer $OPENAI_API_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'name': 'Documentos FURIA'}),
  );

  if (response.statusCode == 200) {
    final id = jsonDecode(response.body)['id'];
    print("Vector Store criada: $id");
    return id;
  } else {
    throw Exception("Erro ao criar vector store: ${response.body}");
  }
}

Future<String> carregarEDepositarPDF() async {
  final byteData = await rootBundle.load('assets/pdfs/Furia_Esports.pdf');
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/Furia_Esports.pdf');
  await file.writeAsBytes(byteData.buffer.asUint8List());

  final stream = http.ByteStream(file.openRead());
  final length = await file.length();

  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.openai.com/v1/files'),
  );

  request.headers['Authorization'] = 'Bearer $OPENAI_API_KEY';
  request.fields['purpose'] = 'assistants';

  request.files.add(
    http.MultipartFile('file', stream, length, filename: 'Furia_Esports.pdf'),
  );

  final response = await request.send();
  final body = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    final fileId = jsonDecode(body)['id'];
    print("PDF enviado com sucesso: $fileId");
    return fileId;
  } else {
    throw Exception("Erro ao fazer upload do PDF: $body");
  }
}

Future<void> adicionarArquivoAoVectorStore(
    String vectorStoreId, String fileId) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/vector_stores/$vectorStoreId/files'),
    headers: {
      'Authorization': 'Bearer $OPENAI_API_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'file_id': fileId}),
  );

  if (response.statusCode == 200) {
    print("Arquivo adicionado à Vector Store.");
  } else {
    throw Exception("Erro ao adicionar arquivo: ${response.body}");
  }
}

Future<void> atualizarAssistenteComVectorStore(
    String assistantId, String vectorStoreId) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/assistants/$assistantId'),
    headers: {
      'Authorization': 'Bearer $OPENAI_API_KEY',
      'Content-Type': 'application/json',
      'OpenAI-Beta': 'assistants=v2',
    },
    body: jsonEncode({
      "tool_resources": {
        "file_search": {
          "vector_store_ids": [vectorStoreId]
        }
      }
    }),
  );

  if (response.statusCode == 200) {
    print("Assistente atualizado com Vector Store.");
  } else {
    throw Exception("Erro ao atualizar assistente: ${response.body}");
  }
}
