import 'package:supabase_flutter/supabase_flutter.dart';

/// Shorthand for server functions that return a set of rows.
extension RpcRows on SupabaseClient {
  Future<List<Map<String, dynamic>>> rpcRows(
    String function, {
    Map<String, dynamic>? params,
  }) async {
    final rows = await rpc<List<dynamic>>(function, params: params);
    return rows.cast<Map<String, dynamic>>();
  }
}
