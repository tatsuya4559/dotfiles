vim9script

import './webutils.vim'

def OpenAWSProviderDocument(): void
  const type = substitute(getline('.'), ' .*', '', '')
  const url_type = {
    resource: 'resources',
    data: 'data-sources',
  }[type]
  const name = substitute(expand('<cword>'), '^aws_', '', '')
  var pv = trim(system('ls .terraform/providers/registry.terraform.io/hashicorp/aws/'))
  if v:shell_error == 1
    pv = 'latest'
  endif
  const url = printf(
    'https://registry.terraform.io/providers/hashicorp/aws/%s/docs/%s/%s',
    pv, url_type, name
  )
  webutils.OpenUrl(url)
enddef
nnoremap <silent> <leader>d :call <SID>OpenAWSProviderDocument()<cr>

def OpenExternalModule(): void
  const line = getline('.')
  const regex = '.*\(github\.com.*\)\/\/\(.*\)\?ref=\(.*\)"'
  const repo = substitute(line, regex, '\1', '')
  const path = substitute(line, regex, '\2', '')
  const tag = substitute(line, regex, '\3', '')
  const url = printf('https://%s/tree/%s/%s', repo, tag, path)
  webutils.OpenUrl(url)
enddef
nnoremap <silent> <leader>m :call <SID>OpenExternalModule()<cr>

# brew install iam-policy-json-to-terraform
command! -range IamPolicyJsonToHcl :<line1>,<line2>!iam-policy-json-to-terraform
