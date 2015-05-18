#!/usr/bin/env python
# encoding: utf-8


def build_log_urls(node, path):
    url = node.web_url_for(
        'addon_view_or_download_file',
        path=path.strip('/'),
        provider='osfstorage'
    )
    return {
        'view': url,
        'download': url + '?action=download'
    }


class OsfStorageNodeLogger(object):

    def __init__(self, node, auth, path=None, full_path=None):
        self.node = node
        self.auth = auth
        self.path = path
        self.full_path = full_path

    def log(self, action, extra=None, save=False):
        """Log an event. Wraps the Node#add_log method, automatically adding
        relevant parameters and prefixing log events with `"osf_storage_"`.

        :param str action: Log action. Should be a class constant from NodeLog.
        :param dict extra: Extra parameters to add to the ``params`` dict of the
            new NodeLog.
        """
        params = {
            'node': self.node._id,
            'project': self.node.parent_id,
        }
        # If logging a file-related action, add the file's view and download URLs
        if self.path:
            params.update({
                'path': self.full_path,
                'urls': build_log_urls(self.node, self.path),
            })
        if extra:
            params.update(extra)
        # Prefix the action with osf_storage_
        self.node.add_log(
            action='osf_storage_{0}'.format(action),
            params=params,
            auth=self.auth,
        )
        if save:
            self.node.save()